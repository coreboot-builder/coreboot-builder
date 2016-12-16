class DropChoicesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :choices
  end
end
