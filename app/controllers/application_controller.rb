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

  def current_deck
    current_user.decks.find_by(current: true) if current_user
  end

  def current_cards
    current_deck ? current_deck.cards : user_cards
  end
end
