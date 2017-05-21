class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :uuid, unique: true, null: false
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
