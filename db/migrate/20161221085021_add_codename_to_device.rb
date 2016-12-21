class AddCodenameToDevice < ActiveRecord::Migration[5.0]
  def change
  	add_column :devices, :codename, :string
  end
end
