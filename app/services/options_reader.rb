class OptionsReader
  def run
    ActiveRecord::Base.transaction do
      json_data = JSON.parse(File.read("#{Rails.root}/config/options/options.json"))

      json_data.each do |key, value|

        unless option = Option.find_by(label: key)
          raise "Option #{key} not found"
        end
        option.option_values.each(&:destroy)

        if option.data_type == "enum"
          value.each do |enum_key, enum_value|
            option.option_values.create(enum_option: enum_key, value: enum_value)
          end
        else
          if value.kind_of?(Array)
            value.each do |value_entry|
              option.option_values.create(value: value_entry)
            end
          else
            option.option_values.create(value: value)
          end
        end
      end
    end
  end

  private

  def read_file(file)
    json_data = JSON.parse(File.read(file))
  end
end
