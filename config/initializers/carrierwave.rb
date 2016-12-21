CarrierWave.configure do |config|
  config.sftp_host = ENV['SFTP_HOST']
  config.sftp_user = ENV['SFTP_USER']
  config.sftp_folder = ENV['SFTP_FOLDER']
  config.sftp_url = ENV['SFTP_URL']
  config.sftp_options = {
    :password => ENV['SFTP_PASSWORD'],
    :port     => ENV['SFTP_PORT']
  }
end
