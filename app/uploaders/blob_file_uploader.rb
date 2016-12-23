# encoding: utf-8

class BlobFileUploader < CarrierWave::Uploader::Base
  storage :sftp

  def filename
    'rom.bin'
  end

  def store_dir
    "#{ENV['SFTP_BASE_DIR']}/#{model.uuid}"
  end
end
