class AddInitialTabels < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name
    end

    create_table :devices do |t|
      t.string :name
      t.string :config_file
      t.boolean :needs_rom_dump
      t.belongs_to :vendor
    end

    create_table :options do |t|
      t.string :label
    end

    create_table :devices_options, id: false do |t|
      t.belongs_to :device
      t.belongs_to :option
    end

    create_table :builds do |t|
      t.string :uuid
      t.integer :state, default: 0
      t.string :blob_file
      t.string :email
      t.string :gpg
      t.belongs_to :device
      t.boolean :downloaded
    end

    create_table :choices do |t|
      t.belongs_to :option
      t.belongs_to :build
      t.string :value
    end
  end
end
