class Teacher < ActiveRecord::Base
  #attr_accessor :email, :name, :password, :profil_image

  def self.authenticate(email="", password="")
    @teacher = Teacher.find_by_email(email)

    if @teacher
      if @teacher.password == password
        return @teacher
      end
    end
  end
end
