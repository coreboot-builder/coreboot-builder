class AddStateToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :state, :integer, default: 0
  end
end
