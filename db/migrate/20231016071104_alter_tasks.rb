class AlterTasks < ActiveRecord::Migration[7.0]
  def up
    add_column :tasks, :creator_id, :integer, null: false, index: true, foreign_key: true
    rename_column :tasks, :task_name, :title
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :status, :integer, default: 0
    remove_column :tasks, :date, :integer
    add_column :tasks, :date, :date, null: false
    change_column :tasks, :description, :text, null: false
  end

  def down
    change_column :tasks, :description, :text, null: true
    remove_column :tasks, :date
    add_column :tasks, :date, :integer
    change_column :tasks, :status, :integer, default: nil
    change_column :tasks, :title, :string, null: true
    rename_column :tasks, :title, :task_name
    remove_column :tasks, :creator_id
  end
end
