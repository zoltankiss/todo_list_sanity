class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project_id, index: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
