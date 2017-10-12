class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: :destroy

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = 'Login successfully'
      redirect_back_or_to root_url
    else
      flash.now[:danger] = 'Login failed'
      render action: :new
    end
  end

  def destroy
    logout
    flash[:success] = 'Logged out!'
    redirect_to root_url
  end
end
