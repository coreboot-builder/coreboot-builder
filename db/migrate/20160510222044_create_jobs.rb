class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :uuid
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
