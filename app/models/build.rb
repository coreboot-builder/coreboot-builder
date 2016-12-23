class Build < ActiveRecord::Base
  validates :state, presence: true
  validates :email, presence: true

  belongs_to :device
  has_many :configurations

  before_validation :create_uuid, unless: :uuid_present?

  mount_uploader :blob_file, BlobFileUploader

  enum state: {
    unconfigured: 0,
    configured: 10,
    pending: 20,
    succeeded: 30,
    failed: 40
  }

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
