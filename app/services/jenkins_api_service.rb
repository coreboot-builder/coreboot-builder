require 'jenkins_api_client'

class JenkinsAPIService
  class << self
    def start_job!(json_config)
      client = JenkinsApi::Client.new(
        server_url: ENV['JENKINS_SERVER_URL'],
        username: ENV['JENKINS_USERNAME'],
        password: ENV['JENKINS_PASSWORD'],
      )

      job = JenkinsApi::Client::Job.new(client)

      json_config['options'] = json_config['options'].join("\n")

      job.build(ENV['JENKINS_BUILD_JOB_NAME'], json_config)
    end
  end
end
