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
      SuperMemo2.new(@card, params[:quality]).arrange_review_date
      redirect_to root_url
    elsif @card.typo?(answer)
      flash[:info] = t('.typo_info', answer: answer,
                        original_text: @card.original_text,
                        translated_text: @card.translated_text)
      render action: :home
    else
      flash[:danger] = t('.wrong')
      @card.wrong_guess_counter
      check_wrong_guesses_number(@card)
    end
  end

  private

  def check_wrong_guesses_number(card)
    return render action: :home if card.wrong_guess <= 3
    # quality = 0, after 3 wrong guesses
    SuperMemo2.new(card, 0).arrange_review_date
    flash[:danger] = t('.limit')
    redirect_to root_url
  end
end
