class AddConfig < ActiveRecord::Migration[5.0]
  def change
    create_table :option_values do |t|
      t.belongs_to :option
      t.string :value
      t.string :enum_option
    end
  end
end
