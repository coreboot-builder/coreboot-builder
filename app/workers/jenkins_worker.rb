class JenkinsWorker
  include Sidekiq::Worker

  def perform(build_id)
    build = Build.find(build_id)

    build.create_jenkins_config

    JenkinsAPIService.start_job!(build.config) if Rails.env.production?

    build.update(state: Build.states[:pending])
  end
end
