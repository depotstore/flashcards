class StaticPagesController < ApplicationController
  def home
    @card = Card.review_date_over.random_card
    # if there aren't any card with overdue date
    @card = Card.random_card unless @card.instance_of?(Card)
  end

  def check_answer
    @card = Card.find(params[:checked_card_id])
    if @card.check_translation(params[:translation])
      flash[:success] = 'Правильно'
      @card.arrange_review_date(Time.now)
      redirect_to root_url
    else
      flash[:danger] = 'Не правильно'
      render action: :home
    end
  end
end
