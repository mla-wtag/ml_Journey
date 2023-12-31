class CreateJournals < ActiveRecord::Migration[7.0]
  def up
    create_table :journals do |t|
      t.string :title
      t.integer :date
      t.text :content
      t.text :goals_today
      t.text :goals_tomorrow
      t.timestamps
    end
  end

  def down
    drop_table :journals
  end
end
