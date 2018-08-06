class DeleteNotNullDisplayNameToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :display_name, :string, null: true
  end
end
