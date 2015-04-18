class CreateCourseToStudentNotes < ActiveRecord::Migration
  def change
    create_table :course_to_student_notes do |t|
      t.string :course_no
      t.string :note
      t.string :student_no

      t.timestamps
    end
  end
end
