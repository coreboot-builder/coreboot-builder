class CreateUsers < ActiveRecord::Migration
  def change  
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.string :email, null: false, unique: true
      t.string :gpg, null: false, unique: true
      t.timestamps null: false
    end
  end
end
