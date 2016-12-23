class BuildsController < ApplicationController
  before_action :load_build, except: [:new, :create]

  def new
    @build = Build.new
  end

  def create
    @build = Build.new(build_params)
    if @build.save
      redirect_to choose_device_build_path(@build)
    else
      flash[:error] = t('.error')
      render :new
    end
  end

  def choose_device
  end

  def update_device
    if @build.update(device_params)
      if @build.device.needs_rom_dump?
        redirect_to choose_rom_build_path(@build)
      else
        redirect_to choose_options_build_path(@build)
      end
    else
      flash[:error] = t('.error')
      render :choose_device
    end
  end

  def choose_rom
  end

  def update_rom_file
    if @build.update(rom_file_params)
      redirect_to choose_options_build_path(@build)
    else
      flash[:error] = t('.error')
      render :choose_rom
    end
  end

  def choose_options
  end

  def update_options
    params.require(:build).permit(
      @build.device.options.select{ |o| o.active? }.map(&:label).to_hash
    ).each do |conf_param|
      binding.pry
      #build.configurations.create(option: )
    end

    if @build.update(option_params)
      redirect_to choose_gpg_build_path(@build)
    else
      flash[:error] = t('.error')
      render :choose_options
    end
  end

  def choose_gpg
  end

  def update_gpg
    if @build.update(gpg_params)
      redirect_to build_path(@build)
    else
      flash[:error] = t('.error')
      render :choose_gpg
    end
  end

  def show
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
    params.require(:build).permit(:gpg)
  end

  def load_build
    @build ||= Build.find(params[:id])
  end
end
