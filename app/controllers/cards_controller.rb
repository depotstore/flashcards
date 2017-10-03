class CardsController < ApplicationController
  before_action :set_card, only: %i[edit update destroy]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      flash[:success] = 'Card created.'
      redirect_to cards_path
    else
      flash_danger
      render 'new'
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      flash[:success] = 'Card updated.'
      redirect_to cards_path
    else
      flash_danger
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    flash[:success] = 'Card deleted.'
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def flash_danger
    flash[:danger] = 'Something wrong.'
  end

end
