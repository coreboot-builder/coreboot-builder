class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :gpg
      t.timestamps null: false
    end
  end
end
