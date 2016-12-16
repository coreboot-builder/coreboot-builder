class Build < ActiveRecord::Base
  validates :uuid, presence: true
  validates :state, presence: true

  belongs_to :device

  mount_uploader :blob_file, BlobFileUploader

  enum state: {
         unconfigured: 0,
         configured: 10,
         pending: 20,
         succeeded: 30,
         failed: 40
       }
end
