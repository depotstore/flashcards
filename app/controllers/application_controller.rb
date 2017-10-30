class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    locale = current_user&.language || params[:locale] || session[:locale] ||
             http_accept_language.compatible_language_from(I18n.available_locales)
     if locale && I18n.available_locales.include?(locale.to_sym)
       session[:locale] = I18n.locale = locale.to_sym
     end
  end

  def not_authenticated
    flash[:danger] = 'Please login first'
    redirect_to login_path
  end

  def user_cards
    current_user&.cards
  end

  def current_deck
    current_user.decks.find_by(id: current_user.current_deck_id) if current_user
  end

  def current_cards
    current_deck ? current_deck.cards : user_cards
  end
end
