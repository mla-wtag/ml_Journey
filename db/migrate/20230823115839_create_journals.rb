class CreateJournals < ActiveRecord::Migration[7.0]

	def up
		create_table :journals, id: false do |t|
			t.integer :journal_id, primary_key: true
			t.integer :user_id 
			t.string :title
			t.integer :date
			t.text :content
			t.text :goalstoday
			t.text :goalstomorrow
			t.timestamps
		end
		
		add_index :journals, :user_id
	end

	def down
		drop_table :journals
	end
	
end	