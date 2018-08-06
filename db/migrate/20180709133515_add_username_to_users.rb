class AddUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, null: false
    rename_column :users, :name, :display_name

    add_index :users, :username, :unique => true
    add_index :users, :email, :unique => true
  end
end
