CarrierWave.configure do |config|
  config.storage = :webdav
  config.webdav_server = ENV['WEBDAV_URL']
  config.webdav_username = ENV['WEBDAV_USERNAME']
  config.webdav_password = ENV['WEBDAV_PASSWORD']
end
