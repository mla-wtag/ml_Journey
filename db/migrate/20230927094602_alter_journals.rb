class AlterJournals < ActiveRecord::Migration[7.0]
  def up
    add_column :journals, :user_id, :integer, index: true, foreign_key: true
    remove_column :journals, :date
    add_column :journals, :date, :date
  end

  def down
    remove_column :journals, :date
    add_column :journals, :date, :integer
    remove_column :journals, :user_id
  end
end
