class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :gpg, null: false, unique: true
      t.timestamps null: false
    end
  end
end
