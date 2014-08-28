class FixTasksReferencesColumn < ActiveRecord::Migration
  def change
    remove_column :tasks, :project_id_id
    add_column :tasks, :project_id, :integer
  end
end
