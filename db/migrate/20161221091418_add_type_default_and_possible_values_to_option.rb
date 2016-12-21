class AddTypeDefaultAndPossibleValuesToOption < ActiveRecord::Migration[5.0]
  def change
  	add_column :options, :data_type, :string
  	add_column :options, :default, :string
  	add_column :options, :possible_values, :string
  end
end
