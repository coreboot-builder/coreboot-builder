class Api::V1::DevicesController < ApplicationController
  def index

    devices = Device.select(:id, :name)
      .where(vendor_id: params[:vendor_id])

    devices_data = devices.map do |device|
      {
        id: device.id,
        label: device.name,
        value: device.name
      }
    end

    respond_to do |format|
      format.json  { render :json => devices_data }
    end
  end
end
