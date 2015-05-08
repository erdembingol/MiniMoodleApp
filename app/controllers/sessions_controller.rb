class SessionsController < ApplicationController
  def index
      redirect_to url_for(:controller => :sessions, :action => :login)
  end

  def login

  end

  def login_control
      @student = Student.authenticate(params[:student_number], params[:password])
      if @student
          session[:student_id] = params[:student_number]
          #flash[:notice] = 'Welcome again, you logged in ' + @student.name
          redirect_to url_for(:controller => :student_ui, :action => :index)
      else
          flash[:notice] = 'Invalid Username or Password'
          flash[:color]= 'invalid'
          redirect_to url_for(:controller => :sessions, :action => :index)
      end
  end

  def logout
      session[:student_id] = nil
      redirect_to :action => 'login'
  end

  def signup
      @student = Student.new
  end

  def signup_control
      @student = Student.new
      @student.name = params[:name]
      @student.password = params[:password]
      @student.profil_image = params[:profil_image]
      @student.student_number = params[:student_number]
      @student.email = params[:email]
      if @student.save
          File.open(Rails.root.join('app/assets', 'images', params[:profil_image]), 'wb') do |f| f.write(params[:profil_image]) end
          session[:student_id] = params[:student_number]
          redirect_to url_for(:controller => :student_ui, :action => :index), :notice => "User was saved"
      else
          render 'signup'
      end
  end
end
