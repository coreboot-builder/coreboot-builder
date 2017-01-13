class Api::V1::BuildsController < ApiController
  before_action :check_api_token

  # PATCH /api/v1/build/:id/finish
  def finish
    build = Build.find(params[:id])

    if build.update(state: Build.states[:succeeded])
      BuildMailer.build_done_mail(build).deliver
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # PATCH /api/v1/build/:id/fail
  def fail
    build = Build.find(params[:id])

    if build.update(state: Build.states[:failed])
      BuildMailer.build_done_mail(build).deliver
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # PATCH /api/v1/build/:id/start
  def start
    build = Build.find(params[:id])

    if build.update(state: Build.states[:build_started])
      BuildMailer.build_started_mail(build).deliver
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
