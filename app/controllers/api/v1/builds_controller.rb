class Api::V1::BuildsController < ApiController
  before_action :check_api_token, except: [:state]

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

    if build.update(state: Build.states[:started])
      BuildMailer.build_started_mail(build).deliver
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # GET /api/v1/build/:id/state
  def state
    build = Build.find(params[:id])

    render json: { state: build.state }
  end
end
