class CreateProjectToFiles < ActiveRecord::Migration
  def change
    create_table :project_to_files do |t|
      t.string :project_no
      t.string :file_no

      t.timestamps
    end
  end
end
