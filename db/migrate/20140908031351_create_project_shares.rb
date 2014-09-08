class CreateProjectShares < ActiveRecord::Migration
  def change
    create_table :project_shares do |t|
      t.references :user
      t.references :project
      t.timestamps
    end
  end
end
