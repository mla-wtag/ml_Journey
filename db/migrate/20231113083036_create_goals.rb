class CreateGoals < ActiveRecord::Migration[7.0]
  def up
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :date, null: false
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :goals
  end
end
