class CreateEnrols < ActiveRecord::Migration
  def change
    create_table :enrols do |t|
      t.text :student_no
      t.text :course_no

      t.timestamps
    end
  end
end
