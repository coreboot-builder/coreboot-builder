class AddCommitToDevice < ActiveRecord::Migration[5.0]
  def change
  	add_column :devices, :commit, :string
  end
end
