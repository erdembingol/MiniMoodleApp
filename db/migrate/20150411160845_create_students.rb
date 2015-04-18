class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :password
      t.string :profil_image
      t.string :student_number

      t.timestamps
    end
  end
end
