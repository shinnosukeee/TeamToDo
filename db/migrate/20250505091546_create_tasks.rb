class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.integer :status, default: 0
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
