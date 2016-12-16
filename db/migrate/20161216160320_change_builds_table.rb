class ChangeBuildsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :builds, :config, :json
  end
end
