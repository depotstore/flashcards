class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: :home

  def home
    @card = current_cards.review_date_over.random_card if current_user
  end

  def check_answer
    @card = user_cards.find(params[:checked_card_id])
    if @card.check_translation(params[:translation])
      flash[:success] = 'Правильно'
      @card.arrange_review_date
      redirect_to root_url
    else
      flash[:danger] = 'Не правильно'
      render action: :home
    end
  end
end
