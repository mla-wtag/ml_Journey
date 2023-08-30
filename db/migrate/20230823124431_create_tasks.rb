class CreateTasks < ActiveRecord::Migration[7.0]

	def up
		create_table :tasks, id: false do |t|
			t.integer :task_id, primary_key: true
			t.integer :user_id 
			t.string :taskname
			t.text :description
	    	t.integer :date 
	    	t.integer :status, limit: 3
	    	t.timestamps
		end
		
		add_index :tasks , :user_id
	end
	
	def down
		drop_table :tasks 
	end

end
