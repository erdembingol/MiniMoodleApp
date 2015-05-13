class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.text :student_no
      t.text :course_no
      t.text :project_no
      t.text :grade

      t.timestamps
    end
  end
end
