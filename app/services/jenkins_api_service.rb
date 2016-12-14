require 'jenkins_api_client'

class JenkinsAPIService
  class << self
    def start_job!(uuid)
      JenkinsApi::Client::Job.build(ENV['JENKINS_BUILD_JOB_NAME'], {
        uuid: uuid
      })
    end
  end
end
