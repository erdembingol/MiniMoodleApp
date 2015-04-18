class StudentUiController < ApplicationController
  def index
      @my_courses = CourseToStudent.find_by_sql("SELECT c.no AS course_no, c.name AS course_name, t.name AS teacher_name
                                                 FROM courses c, course_to_students cts, teachers t
                                                 WHERE cts.course_no = c.no and c.teacher_no = t.name and cts.student_no = '#{session[:student_id]}'")
  end

  def all_courses
      @all_courses = Course.all
  end

  def my_courses
    @my_courses = CourseToStudent.find_by_sql("SELECT c.no AS course_no, c.name AS course_name, t.name AS teacher_name
                                                 FROM courses c, course_to_students cts, teachers t
                                                 WHERE cts.course_no = c.no and c.teacher_no = t.name and cts.student_no = '#{session[:student_id]}'")
  end

  def course
      @course = Course.find(id, params[:id])
      @lectures = Record.find_by_sql 'SELECT r.* FROM records r, course_lecture_to_files cltf WHERE cltf.course_no = ' + @course.id + ' and cltf.file_no = r.id'
      @projects = Project.find_by_sql 'SELECT p.* FROM projects p, course_to_projects ctp WHERE ctp.project_no = p.id and ctp.course_no = ' + @course.id
      @files = Record.find_by_sql 'SELECT r.name, r.path, ptf.project_no FROM records r, project_to_files ptf, course_to_projects ctp WHERE ctp.course_no = ' + @course.id + ' and ctp.project_no = ptf.project_no and ptf.file_no = r.id'
  end

  def my_profile
      @student = Student.find_by_student_number(session[:student_id])
      @courses = CourseToStudent.find_by_sql 'SELECT c.name AS course_name
                                              FROM courses c, course_to_students cts
                                              WHERE cts.course_no = c.no and cts.student_no = ' + session[:student_id]
  end

  def edit_profile
      @student = Student.find_by_student_number(session[:student_id])
  end

  def edit_profile_control
    @student = Student.find_by_student_number(session[:student_id])
    @student.name = params[:name]
    @student.password = params[:password]
    @student.profil_image = params[:profil_image]
    @student.student_number = params[:student_number]
    @student.email = params[:email]
    if @student.save
      File.open(Rails.root.join('app/assets', 'images', params[:profil_image]), 'wb') do |f| f.write(params[:profil_image]) end
      redirect_to url_for(:controller => :student_ui, :action => :index), :notice => "User was saved"
    else
      render 'index'
    end
  end

  def grades

  end

  def enrol

  end
end
