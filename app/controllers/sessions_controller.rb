class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: [:destroy]
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      user_params
    )

    if @user.nil?
      @user = User.new
      flash.now[:danger] = ['Invalid username and/or password']
      render :new
    else
      login!(@user)
      redirect_to root_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end