class Api::V1::VendorsController < ApplicationController
  def index
    # TODO Filter params

    vendors = Vendor.select(:id, :name).where("name ILIKE '%#{params[:term]}%'")

    vendors_data = vendors.map do |vendor| 
      {
        id: vendor.id,
        label: vendor.name,
        value: vendor.name
      }
    end

    respond_to do |format|
      format.json  { render :json => { items: vendors_data } }
    end
  end
end
