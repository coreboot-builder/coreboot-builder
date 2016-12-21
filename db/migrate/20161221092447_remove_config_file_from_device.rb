class RemoveConfigFileFromDevice < ActiveRecord::Migration[5.0]
  def change
  	remove_column :devices, :config_file
  end
end
