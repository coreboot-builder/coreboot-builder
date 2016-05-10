require 'jenkins_api_client'

class JenkinsAPIService
  class << self
    def build!(uuid)
      yield uuid
    end

    def isBuilding?
      yield result
    end
  end
end
