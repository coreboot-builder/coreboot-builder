class BuildsController < ApplicationController
  before_action :load_build, except: [:index, :start, :new, :create]
  layout 'frontend'

  def start
  end

  def index
    if build_params[:email].present?
      @builds = Build.where(email: build_params[:email])
      @email = build_params[:email]
    else
      flash[:error] = "Email field can't be blank"
      redirect_to new_build_path
    end
  end

  def new
    @build = Build.new
  end

  def create
    @build = Build.new(build_params)
    if @build.save
      redirect_to choose_device_build_path(@build)
    else
      flash.now[:error] = @build.errors.full_messages.to_sentence
      render :new
    end
  end

  def update_device
    device_id = device_params[:device_model]
    if @build.update(device_id: device_id, state: Build.states[:device_chosen])

      if @build.device.needs_rom_dump?
        redirect_to choose_rom_build_path(@build)
      else
        redirect_to choose_options_build_path(@build)
      end
    else
      flash.now[:error] = @build.errors.full_messages.to_sentence
      render :choose_device
    end
  end

  def update_rom_file
    if @build.update(rom_file_params.merge({state: Build.states[:blob_file_uploaded]}))
      redirect_to choose_options_build_path(@build)
    else
      flash.now[:error] = @build.errors.full_messages.to_sentence
      render :choose_rom
    end
  end

  def update_options
    params.require(:build).permit(
      @build.device.options.select{ |o| o.active? }.map(&:label)
    ).each do |conf_param|
      option = Option.find_by(label: conf_param)
      option.option_values.each do |option_value|
        @build.configurations.create(option: option, value: option_value.value)
      end
    end

    if @build.update(state: Build.states[:options_configured])
      redirect_to choose_gpg_build_path(@build)
    else
      flash.now[:error] = @build.errors.full_messages.to_sentence
      render :choose_options
    end
  end

  def update_gpg
    if @build.update(gpg_params.merge({state: Build.states[:configured]}))
      JenkinsWorker.perform_async(@build.id)
      redirect_to build_path(@build)
    else
      flash.now[:error] = @build.errors.full_messages.to_sentence
      render :choose_gpg
    end
  end

  private

  def build_params
    params.require(:build).permit(:email)
  end

  def device_params
    params.require(:build).permit(:device_model)
  end

  def rom_file_params
    params.require(:build).permit(:blob_file)
  end

  def gpg_params
    params.require(:build).permit(:gpg, :gpg_name)
  end

  def load_build
    @build ||= Build.find(params[:id])
  end
end
