class SessionsController < ApplicationController
  skip_before_filter :authenticate
  skip_before_filter :build_resource_class
  skip_before_filter :build_resource_instance
  skip_before_filter :authorize_person

  def new
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.username}"
      redirect_to users_path
    else
      flash[:alert] = 'Invalid Username/Password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end