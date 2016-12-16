class AddUuidToBuildsTable < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    remove_column :builds, :uuid
    add_column :builds, :uuid, :uuid, null: false

    add_index :builds, :uuid, unique: true
  end
end
