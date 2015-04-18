class CreateProjectToStudentNotes < ActiveRecord::Migration
  def change
    create_table :project_to_student_notes do |t|
      t.string :note
      t.string :project_no
      t.string :student_no

      t.timestamps
    end
  end
end
