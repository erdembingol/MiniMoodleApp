class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :explain
      t.string :name

      t.timestamps
    end
  end
end
