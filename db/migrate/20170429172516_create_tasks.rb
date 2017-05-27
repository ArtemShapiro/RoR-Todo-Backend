class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.boolean :done, null: false, default: false
      t.datetime :deadline
      t.integer :priority
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
  end
end
