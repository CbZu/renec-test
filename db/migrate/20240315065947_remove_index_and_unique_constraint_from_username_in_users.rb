class RemoveIndexAndUniqueConstraintFromUsernameInUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :username
    remove_column :users, :username, :string, unique: true
  end
end
