class SessionsTeacherController < ApplicationController

  def index
    redirect_to url_for(:controller => :sessions_teacher, :action => :login_teacher)
  end

  def logout_teacher
    session[:teacher_id] = nil
    redirect_to :action => 'login_teacher'
  end

  def login_teacher

  end

  def login_teacher_control
    @teacher = Teacher.authenticate(params[:email], params[:password])
    if @teacher
      session[:teacher_id] = @teacher.id
      #flash[:notice] = 'Welcome again, you logged in ' + @student.name
      redirect_to url_for(:controller => :teacher_ui, :action => :index)
    else
      flash[:notice] = 'Invalid Username or Password'
      flash[:color]= 'invalid'
      redirect_to url_for(:controller => :sessions_teacher, :action => :index)
    end
  end

  def signup_teacher
    @teacher = Teacher.new
  end

  def signup_teacher_control
    @teacher = Teacher.new
    @teacher.name = params[:name]
    @teacher.password = params[:password]
    @teacher.profil_image = params[:profil_image]
    @teacher.email = params[:email]
    if @teacher.save
      File.open(Rails.root.join('app/assets', 'images', params[:profil_image]), 'wb') do |f| f.write(params[:profil_image]) end
      session[:teacher_id] = Teacher.last.id
      redirect_to url_for(:controller => :teacher_ui, :action => :index), :notice => "User was saved"
    else
      render 'signup_teacher'
    end
  end

end
