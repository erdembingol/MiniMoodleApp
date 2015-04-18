class CreateCourseToProjects < ActiveRecord::Migration
  def change
    create_table :course_to_projects do |t|
      t.string :course_no
      t.string :project_no

      t.timestamps
    end
  end
end
