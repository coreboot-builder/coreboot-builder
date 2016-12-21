class AddConfigurations < ActiveRecord::Migration[5.0]
  def change
    create_table :configurations do |t|
      t.references :build
      t.references :option
      t.string :value
    end
  end
end
