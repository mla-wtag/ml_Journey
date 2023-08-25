class CreateUsers < ActiveRecord::Migration[7.0]

	def up 
		create_table :users, id: false do |t|
			t.integer :user_id, primary_key: true
			t.string :firstname, limit: 100, null: false
			t.string :lastname, limit: 100, nul: false
			t.integer :employee_id
			t.date :date_of_birth
			t.date :joining_day
			t.string :designation, limit: 50
			t.binary :profile_picture, limit: 10.megabytes
			t.string :email
			t.timestamps
		end

	end

	def down
		drop_table :users
	end
	
end
