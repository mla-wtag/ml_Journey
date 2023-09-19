class AlterUsers2 < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :profile_picture
    add_column :users, :role, :integer, default: 0
  end

  def down
    add_column :users, :profile_picture, :binary
    remove_column :users, :role
  end
end
