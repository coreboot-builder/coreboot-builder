# encoding: utf-8

class BlobFileUploader < CarrierWave::Uploader::Base
  def filename
    'rom.bin'
  end

  def store_dir
    "#{model.uuid}"
  end
end
