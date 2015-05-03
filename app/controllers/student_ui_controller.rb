class StudentUiController < ApplicationController
  def index
    @my_courses = Course.find_by_sql("SELECT c.no, c.name, c.teacher_no
                                      FROM courses c, course_to_students cts
                                      WHERE cts.course_no = c.no and cts.student_no = '#{session[:student_id]}'")
  end

  def all_courses
      @all_courses = Course.all
  end

  def my_courses
      @my_courses = Course.find_by_sql("SELECT c.no, c.name, c.teacher_no
                                        FROM courses c, course_to_students cts
                                        WHERE cts.course_no = c.no and cts.student_no = '#{session[:student_id]}'")
  end

  def course
      @course = Course.find_by_no(params[:course_no].to_s)

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
    @grades = Grade.all
    @result = 0;
  end

  def enrol
    @enrol = Enrol.new
    @enrol.student_no = session[:student_id]
    @enrol.course_no = params[:course_no]

    @enrol.save
    redirect_to url_for(:controller => :student_ui, :action => :all_courses)
  end

  def uploadFile
    upload = params[:upload]
    name =  upload['datafile'].original_filename
    directory = "app/public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }

    @upload = Upload.new
    @upload.student_no = session[:student_id]
    @upload.course_no = session[:course_id]
    @upload.project_no = params[:project_id]
    @upload.file_name = name
    @upload.file_path = 'app/public/data/' + name
    @upload.save

    #render :text => "File has been uploaded successfully"
    redirect_to url_for(:controller => :student_ui, :action => :my_courses)
  end

  def downloadFile
    temp = params[:name].to_s.split('.');
    send_file(
        "#{Rails.root}/app/public/data/" + params[:name],
        filename: params[:name],
        type: "application/" + temp[1]
    )
  end

  # def downloadFile
  #   @records = Record.all
  #   @records.each do |record|
  #       temp = record.path.split('.')
  #       record.name = record.name + '.' + temp[1]
  #       record.save
  #   end
  # end
end
