# no :doc
class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: :home

  def home
    @card = current_cards.review_date_over.random_card if current_user
  end

  def check_answer
    answer = params[:translation]
    @card = user_cards.find(params[:checked_card_id])
    if @card.check_translation(answer)
      flash[:success] = t('.right')
      @card.arrange_review_date(1)
      redirect_to root_url
    elsif @card.typo?(answer)
      flash[:info] = t('.typo_info', answer: answer,
                        original_text: @card.original_text,
                        translated_text: @card.translated_text)
      render action: :home
    else
      flash[:danger] = t('.wrong')
      @card.wrong_guess_counter
      check_wrong_guesses_number(@card.wrong_guess)
    end
  end

  private

  def check_wrong_guesses_number(wrong_guess)
    return render action: :home if wrong_guess <= 3
    @card.arrange_review_date(-1)
    flash[:danger] = t('.limit')
    redirect_to root_url
  end
end
