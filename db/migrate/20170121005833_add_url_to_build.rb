class AddUrlToBuild < ActiveRecord::Migration[5.0]
  def change
    add_column :builds, :url, :string
  end
end
