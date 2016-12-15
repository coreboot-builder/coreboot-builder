# encoding: utf-8

class BlobFileUploader < CarrierWave::Uploader::Base
  storage :webdav

  def store_dir
    "#{ENV['WEBDAV_BASE_DIR']}/#{model.uuid}"
  end
end
