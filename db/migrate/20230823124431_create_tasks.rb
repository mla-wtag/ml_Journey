class CreateTasks < ActiveRecord::Migration[7.0]
  def up
    create_table :tasks do |t|
      t.string :task_name
      t.text :description
      t.integer :date
      t.integer :status
      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
