class AddGpgName < ActiveRecord::Migration[5.0]
  def change
    add_column :builds, :gpg_name, :string
  end
end
