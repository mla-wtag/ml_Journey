class AddNullValidationJournal < ActiveRecord::Migration[7.0]
  def up
    change_column_null :journals, :title, false
    change_column_null :journals, :date, false
    change_column_null :journals, :content, false
    change_column_null :journals, :goals_today, false
    change_column_null :journals, :goals_tomorrow, false
  end

  def down
    change_column_null :journals, :goals_tomorrow, true
    change_column_null :journals, :goals_today, true
    change_column_null :journals, :content, true
    change_column_null :journals, :date, true
    change_column_null :journals, :title, true
  end
end
