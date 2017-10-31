class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[new create]

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
       auto_login @user
       flash[:success] = t('.success')
       redirect_to root_url
     else
       render :new
     end
  end

  def update
    if @user.update(user_params)
      redirect_back fallback_location: @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t('.success')
    redirect_to root_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
        :authentications_attribute, :current_deck_id, :language)
    end
end
