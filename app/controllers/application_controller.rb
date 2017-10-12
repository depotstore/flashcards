class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def not_authenticated
    flash[:danger] = 'Please login first'
    redirect_to login_url
  end

  def user_cards
    current_user.cards if current_user
  end
end
