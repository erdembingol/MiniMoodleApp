class CreateCourseToStudents < ActiveRecord::Migration
  def change
    create_table :course_to_students do |t|
      t.string :course_no
      t.string :student_no

      t.timestamps
    end
  end
end
