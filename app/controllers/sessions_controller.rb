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
          redirect_to url_for(:controller => :student_ui, :action => :index), :notice => "User was saved"
      else
          render 'signup'
      end
  end

  # def login_teacher
  #
  # end
  #
  # def login_teacher_control
  #     @teacher = Teacher.authenticate(params[:email], params[:password])
  #     if @teacher
  #         session[:user_id] = @teacher.id
  #         flash[:notice] = "Welcome again, you logged in #{@teacher.name}"
  #         redirect_to url_for(:controller => :teacher_ui, :action => :index)
  #     else
  #         flash[:notice] = 'Invalid Username or Password'
  #         flash[:color]= 'invalid'
  #         render 'login_teacher'
  #     end
  # end
  #
  # def signup_teacher
  #     @teacher = Teacher.new
  # end
  #
  # def signup_teacher_control
  #     @teacher = Teacher.new
  #     @teacher.name = params[:name]
  #     @teacher.password = params[:password]
  #     @teacher.profil_image = params[:profil_image]
  #     @teacher.email = params[:email]
  #     if @teacher.save
  #         redirect_to url_for(:controller => :teacher_ui, :action => :index), :notice => "User was saved"
  #     else
  #         render 'signup_teacher'
  #     end
  # end
  #
  # private
  # def student_params
  #   params.require(:student).permit(:email, :name, :password, :profil_image, :student_number)
  # end
end
