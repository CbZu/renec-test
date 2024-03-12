class RenamePasswordAndAddUniqueConstraintToUsernameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :password, :password_digest
    add_index :users, :username, unique: true
  end
end
