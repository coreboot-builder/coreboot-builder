class Api::V1::BuildsController < ApiController
  before_action :check_api_token

  # PATCH /api/v1/build/:id/finish
  def finish
    build = Build.find(params[:id])

    if build.update(state: Bulid.states[:succeeded])
      BuildMailer.build_done_mail(build).deliver
    end

    head :ok
  end

  # PATCH /api/v1/build/:id/fail
  def fail
    build = Build.find(params[:id])

    if build.update(state: Bulid.states[:failed])
      BuildMailer.build_done_mail(build).deliver
    end

    head :ok
  end
end
