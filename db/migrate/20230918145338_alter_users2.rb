class AlterUsers2 < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :profile_picture
    add_column :users, :role, :integer, default: 0
    rename_column :users, :firstname, :first_name
    rename_column :users, :lastname, :last_name
  end

  def down
    rename_column :users, :first_name, :firstname
    rename_column :users, :last_name, :lastname
    add_column :users, :profile_picture, :binary
    remove_column :users, :role
  end
end
