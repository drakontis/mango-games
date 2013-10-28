class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to users_path
    else
      render :new, :alert => 'Invalid Username/Password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end