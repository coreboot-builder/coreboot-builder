class Build < ActiveRecord::Base
  validates :state, presence: true
  validates :email, presence: true
  validates :device, presence: true, if: :device_chosen_or_beyond?
  validates :blob_file, presence: true, if: :blob_file_uploaded_or_beyond_and_needs_rom?
  validates :gpg, presence: true, if: :configured_or_beyond?

  belongs_to :device
  has_many :configurations

  before_validation :create_uuid, unless: :uuid_present?

  mount_uploader :blob_file, BlobFileUploader

  enum state: {
    new_build: 0,
    device_chosen: 10,
    blob_file_uploaded: 20,
    options_configured: 30,
    configured: 40,
    pending: 50,
    started:60,
    succeeded: 70,
    failed: 80
  }

  before_save do |record|
    if record.gpg.present?
      record.gpg = record.gpg.split("\n").map(&:strip).join("\n")
    end
  end

  def device_chosen_or_beyond?
    %w(device_chosen blob_file_uploaded options_configured configured pending started succeeded failed).include?(self.state)
  end

  def blob_file_uploaded_or_beyond_and_needs_rom?
    blob_file_uploaded_or_beyond? && device.try(:needs_rom_dump?)
  end

  def blob_file_uploaded_or_beyond?
    %w(blob_file_uploaded options_configured configured pending started succeeded failed).include?(self.state)
  end

  def configured_or_beyond?
    %w(configured pending started succeeded failed).include?(self.state)
  end

  def state_configured_and_needs_blob?
    state_configured_or_beyond? && device.try(:needs_rom_dump?)
  end

  def create_uuid
    self.uuid = SecureRandom.uuid
  end

  def uuid_present?
    uuid.present?
  end

  def create_jenkins_config
    json_conf = {
      id: id,
      uuid: uuid,
      codename: device.codename,
      commit: device.commit,
      gpg: gpg,
      options: configurations.map(&:value)
    }

    update(config: json_conf)
  end
end
