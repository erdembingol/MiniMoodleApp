class CreateCourseLectureToFiles < ActiveRecord::Migration
  def change
    create_table :course_lecture_to_files do |t|
      t.string :course_no
      t.string :file_no

      t.timestamps
    end
  end
end
