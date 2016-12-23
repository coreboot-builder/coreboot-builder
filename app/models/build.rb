class Build < ActiveRecord::Base
  validates :uuid, presence: true
  validates :state, presence: true

  belongs_to :device
  has_many :configurations

  mount_uploader :blob_file, BlobFileUploader

  enum state: {
    unconfigured: 0,
    configured: 10,
    pending: 20,
    succeeded: 30,
    failed: 40
  }

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
