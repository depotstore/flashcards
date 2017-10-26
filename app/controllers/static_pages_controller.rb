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
      flash[:success] = 'Правильно'
      @card.arrange_review_date(1)
      redirect_to root_url
    elsif @card.typo?(answer)
      flash[:info] = "#{answer} was typed instead of "
      flash[:info] += "#{@card.original_text} (#{@card.translated_text}). Please retype."
      render action: :home
    else
      flash[:danger] = 'Не правильно'
      @card.wrong_guess_counter
      check_wrong_guesses_number(@card.wrong_guess)
    end
  end

  private

  def check_wrong_guesses_number(wrong_guess)
    return render action: :home if wrong_guess <= 3
    @card.arrange_review_date(-1)
    flash[:danger] = 'More than 3 wrong guesses.'
    redirect_to root_url
  end
end
