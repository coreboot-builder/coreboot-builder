class BuildsController < ApplicationController
  before_action :load_build, except: [:index, :start, :new, :create]
  layout 'frontend'

  def start
  end

  def index
    if build_params[:email].present?
      @builds = Build.where(email: build_params[:email])
      @email = build_params[:email]

      if @builds.empty?
        @build = Build.create(email: @email)
        redirect_to choose_device_build_path(@build)
      end
    else
      flash.now[:error] = "Email field can't be blank"
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
    if @build.update(device_params.merge({state: Build.states[:device_chosen]}))
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
    ).each do |option_key, option_value|
      option = Option.find_by(label: option_key)
      case option.data_type
      when 'bool'
        if option_value == 'true'
          @build.configurations.create(option: option, value: option.option_values.first.value)
        end
      when 'enum'
        unless option.option_values.map(&:enum_option).exclude?(option_value)
          option_value = option.option_values.select do |e|
            e.enum_option == option_value
          end.first.value
          @build.configurations.create(option: option, value: option_value)
        end
      else
        flash.now[:error] = "Unknown option type"
        render :choose_options
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
    params.require(:build).permit(:device_id)
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
