class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.text :student_no
      t.text :course_no
      t.text :project_no
      t.text :file_name
      t.text :file_path

      t.timestamps
    end
  end
end
