class Student < ActiveRecord::Base

  #attr_accessor :email, :name, :password, :profil_image, :student_number

  def self.authenticate(student_number, password)
      #return Student.find_by_sql("SELECT * FROM students s WHERE s.student_number = '#{student_number}' and s.password = '#{password}'")
      @student = Student.find_by_student_number(student_number)
      if @student
        if @student.password == password
          return @student
        end
      end
  end

end
