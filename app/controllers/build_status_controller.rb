class BuildStatusController < ApplicationController

  # GET /status/:uuid
  def show
    uuid_param = params[:uuid]

    @job = Job.where(uuid: uuid_param).first()
  end
end
