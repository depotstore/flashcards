class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: :destroy

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = t('.success')
      redirect_back_or_to root_url
    else
      flash.now[:danger] = t('.danger')
      render action: :new
    end
  end

  def destroy
    logout
    flash[:success] = t('.success')
    redirect_to root_url
  end
end
