class RemoveDeviceOptions < ActiveRecord::Migration[5.0]
  def change
  	drop_table :devices_options
  	add_reference :options, :device
  end
end
