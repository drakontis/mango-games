class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to edit_user_path(@user), :notice => 'Account has been successfully created!'
    else
      flash.now[:error] = 'Problem creating account'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user), :notice => 'Account has been successfully updated!'
    else
      flash.now[:error] = 'Problem updating account!'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, :notice => 'Account has been successfully destroyed!'
    else
      flash.now[:error] = 'Problem deleting account!'
      render :index
    end
  end

end