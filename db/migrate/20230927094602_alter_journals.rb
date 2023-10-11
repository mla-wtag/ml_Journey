class AlterJournals < ActiveRecord::Migration[7.0]
  def up
    add_reference :journals, :user, null: false, foreign_key: true
    remove_column :journals, :date
    add_column :journals, :date, :date
  end

  def down
    remove_column :journals, :date
    add_column :journals, :date, :integer
    remove_reference :journals, :user
  end
end
