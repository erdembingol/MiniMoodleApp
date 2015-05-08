class TeacherUiController < ApplicationController

  def index
    @course = Course.find_by_teacher_no(session[:teacher_id])

    @lectures = Record.find_by_sql "SELECT r.*
                                    FROM records r, course_lecture_to_files cltf
                                    WHERE cltf.course_no = '#{@course.id}' and cltf.file_no = r.id"

    @projects = Project.find_by_sql "SELECT p.*
                                     FROM projects p, course_to_projects ctp
                                     WHERE ctp.project_no = p.id and ctp.course_no = '#{@course.id}'"

    @files = Record.find_by_sql "SELECT r.name, r.path, ptf.project_no
                                 FROM records r, project_to_files ptf, course_to_projects ctp
                                 WHERE ctp.course_no = '#{@course.id}' and ctp.project_no = ptf.project_no and ptf.file_no = r.id"

    session[:course_id] = @course.id
  end

  def my_profile
    @teacher = Teacher.find(session[:teacher_id])
  end

  def edit_profile
    @teacher = Teacher.find(session[:teacher_id])
  end

  def edit_profile_control
    @teacher = Teacher.find(session[:teacher_id])
    @teacher.name = params[:name]
    @teacher.password = params[:password]
    @teacher.profil_image = params[:profil_image]
    @teacher.email = params[:email]
    if @teacher.save
      File.open(Rails.root.join('app/assets', 'images', params[:profil_image]), 'wb') do |f| f.write(params[:profil_image]) end
      redirect_to url_for(:controller => :teacher_ui, :action => :index), :notice => "User was saved"
    else
      render 'edit_profile'
    end
  end

  def enrol_list
    @enrol_list = Enrol.find_by_sql "SELECT DISTINCT e.* FROM enrols e, courses c, teachers t WHERE e.course_no = c.no and c.teacher_no = '#{session[:teacher_id]}'"
  end

  def accept_enrol
    @cts = CourseToStudent.new
    @cts.course_no = params[:course_no]
    @cts.student_no = params[:student_no]

    @enrol = Enrol.find_by(:course_no => params[:course_no], :student_no => params[:student_no])

    if @cts.save && Enrol.destroy(@enrol.id)
      redirect_to url_for(:controller => :teacher_ui, :action => :enrol_list), :notice => "User was saved"
    end
  end

  def accept_all_enrol
    @enrol_list = Enrol.find_by_sql "SELECT DISTINCT e.* FROM enrols e, courses c, teachers t WHERE e.course_no = c.no and c.teacher_no = '#{session[:teacher_id]}'"

    i = 0
    @enrol = @enrol_list.at(i)
    while !@enrol.nil? do
      @cts = CourseToStudent.new
      @cts.course_no = @enrol.course_no
      @cts.student_no = @enrol.student_no
      @cts.save
      puts @enrol.id
      Enrol.delete(@enrol.id)
      i = i+1
      @enrol = @enrol_list.at(i)
    end

    redirect_to url_for(:controller => :teacher_ui, :action => :enrol_list), :notice => "User was saved"
  end

  def grading
    @course = Course.find_by_teacher_no(session[:teacher_id])
    @students = Student.find_by_sql "SELECT s.* FROM students s, course_to_students cts
                                     WHERE s.student_number = cts.student_no and cts.course_no = '#{@course.no}'"
  end

  def grade
    
  end

  def create_new_course
    @course = Course.new
  end

  def create_new_course_control
    @course = Course.new
    @course.no = params[:no]
    @course.name = params[:name]
    @course.explain = params[:explain]
    @course.teacher_no = session[:teacher_id]

    if @course.save
      redirect_to url_for(:controller => :teacher_ui, :action => :index), :notice => "User was saved"
    else
      render 'create_new_course'
    end

  end

  def add_project
    @project = Project.new
  end

  def add_project_control
    @project = Project.new
    @project.name = params[:name]
    @project.explain = params[:explain]
    @project.save

    @course_to_project = CourseToProject.new
    @course_to_project.course_no = session[:course_id]
    @course_to_project.project_no = Project.last.id

    if @course_to_project.save
      redirect_to url_for(:controller => :teacher_ui, :action => :index)
    else
      render 'add_project'
    end
  end

  def upload_lecture_file
    upload = params[:upload]
    name =  upload['datafile'].original_filename
    directory = "app/public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }

    @record = Record.new
    @record.path = 'app/public/data/' + name
    @record.name = name
    @record.save

    @record = Record.last

    @course_lecture_to_file = CourseLectureToFile.new
    @course_lecture_to_file.course_no = session[:course_id]
    @course_lecture_to_file.file_no = @record.id
    @course_lecture_to_file.save

    #render :text => "File has been uploaded successfully"
    redirect_to url_for(:controller => :teacher_ui, :action => :index)
  end

  def upload_project_file
    upload = params[:upload]
    name =  upload['datafile'].original_filename
    directory = "app/public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }

    @record = Record.new
    @record.path = 'app/public/data/' + name
    @record.name = name
    @record.save

    @record = Record.last

    @project_to_file = ProjectToFile.new
    @project_to_file.project_no = params[:project_id]
    @project_to_file.file_no = @record.id
    @project_to_file.save

    #render :text => "File has been uploaded successfully"
    redirect_to url_for(:controller => :teacher_ui, :action => :index)
  end

  def download_file
    temp = params[:name].to_s.split('.');
    send_file(
        "#{Rails.root}/app/public/data/" + params[:name],
        filename: params[:name],
        type: "application/" + temp[1]
    )
  end

end
