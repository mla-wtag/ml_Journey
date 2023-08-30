class CreateUsers < ActiveRecord::Migration[7.0]
	def up 
		create_table :users do |t|
			t.string :firstname, null: false
			t.string :lastname, nul: false
			t.integer :employee_id
			t.date :date_of_birth
			t.date :joining_day
			t.string :designation
			t.binary :profile_picture, limit: 10.megabytes
			t.string :email
			t.timestamps
		end
	end
	def down
		drop_table :users
	end
end
