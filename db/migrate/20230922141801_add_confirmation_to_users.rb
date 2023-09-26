class AddConfirmationToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
  end

  def down
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
  end
end
