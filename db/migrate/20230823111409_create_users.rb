class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.integer :employee_id
      t.date :date_of_birth
      t.date :joining_day
      t.string :designation
      t.binary :profile_picture
      t.string :email
      t.string :password_digest
      #t.integer :role, default: 1
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
