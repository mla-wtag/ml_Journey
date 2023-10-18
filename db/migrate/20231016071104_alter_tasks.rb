class AlterTasks < ActiveRecord::Migration[7.0]
  def up
    add_column :tasks, :creator_id, :integer, null: false, index: true, foreign_key: true
    rename_column :tasks, :task_name, :title
    change_column :tasks, :status, :integer, default: 0
    remove_column :tasks, :date, :integer
    add_column :tasks, :date, :date
  end

  def down
    remove_column :tasks, :date, :date
    add_column :tasks, :date, :integer
    change_column :tasks, :status, :integer, default: nil
    rename_column :tasks, :title, :task_name
    remove_column :tasks, :creator_id
  end
end
