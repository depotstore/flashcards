class DecksController < ApplicationController
  before_action :set_deck, only: %i[show edit update destroy]
  # after_action :check_and_falsify, only: %i[create update]

  def index
    @decks = current_user.decks
  end

  def show
    @cards = @deck.cards
    @number = @cards.count
  end

  def new
    @deck = current_user.decks.build
  end

  def edit; end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = 'Deck was successfully created.'
      check_and_falsify
      redirect_to @deck
    else
      render :new
    end
  end

  def update
    current_old = @deck.current
    if @deck.update(deck_params)
      flash[:success] = 'Deck was successfully updated.'
      check_and_falsify unless @deck.current == current_old
      redirect_to @deck
    else
      render :edit
    end
  end

  def destroy
    @deck.destroy
    flash[:success] = 'Deck was successfully destroyed.'
    redirect_to decks_url
  end

  private
  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name, :current)
  end

  def check_and_falsify
    @deck.check_and_falsify(params[:deck][:current])
  end
end
