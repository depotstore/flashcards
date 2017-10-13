class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      flash[:success] = "Logged in from #{provider.titleize}!"
      redirect_to root_path
    else
      begin
        puts "creating user from #{params[:provider]}"
        @user = create_from(provider)
        puts "oauth_user: #{@user.inspect}"
        reset_session # protect from session fixation attack
        auto_login(@user)
        flash[:success] = "Logged in from #{provider.titleize}!"
        redirect_to root_path
      rescue => e
        flash[:danger] = "Failed to login from #{provider.titleize}\n#{e.message}!"
        redirect_to root_path
      end
    end
  end
  private
  def auth_params
    params.permit(:code, :provider)
  end
end
