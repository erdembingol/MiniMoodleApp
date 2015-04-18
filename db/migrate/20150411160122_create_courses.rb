class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :no
      t.string :teacher_no
      t.text :explain

      t.timestamps
    end
  end
end
