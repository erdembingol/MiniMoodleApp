class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :email
      t.string :name
      t.string :password
      t.string :profil_image

      t.timestamps
    end
  end
end
