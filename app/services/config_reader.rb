class ConfigReader
  def run
    ActiveRecord::Base.transaction do
      files = load_config_files
      files.each do |file|
        json_data = read_file(file)

        unless vendor = Vendor.find_or_create_by(name: json_data.fetch('vendor'))
          raise "Could not find or create vendor" unless vendor
        end

        unless device = Device.find_or_create_by(codename: json_data['codename'])
          raise "Could not find or create device" unless device
        end

        unless update_device(device, vendor, json_data)
          raise "Could not update device"
        end

        device.options.update_all(state: 10)

        json_data.fetch('options').each do |option_key, option_value|
          unless option = Option.find_or_create_by(device: device, label: option_key)
            raise "Could not find or create option" unless option
          end

          if option_value.kind_of?(Array)
            unless option.update(data_type: :enum, default: nil, possible_values: option_value.join(","), state: 0)
              raise "Could not update option"
            end
          else
            unless option.update(data_type: :bool, default: option_value, possible_values: nil, state: 0)
              raise "Could not update option"
            end
          end
        end
      end
    end
  end

  private

  def update_device(device, vendor, json_data)
    device.update(
      vendor: vendor,
      name: json_data.fetch('device'),
      commit: json_data.fetch('commit'),
      needs_rom_dump: json_data.fetch('blobs') == 'yes'
    )
  end

  def load_config_files
    files = Dir.glob("#{Rails.root}/config/devices/**/*")
  end

  def read_file(file)
    json_data = JSON.parse(File.read(file))
  end
end
