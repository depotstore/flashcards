class DecksController < ApplicationController
  before_action :set_deck, only: %i[show edit update destroy]

  def index
    @decks = current_user.decks.order(name: :asc)
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
      make_deck_current_if_checked
      flash[:success] = 'Deck was successfully created.'
      redirect_to @deck
    else
      render :new
    end
  end

  def update
    # old_current_deck_id = current_user.current_deck_id
    if @deck.update(deck_params)
      # puts "update old_current_deck_id #{old_current_deck_id}"
      # puts "update current_deck_id #{current_user.current_deck_id}"
      make_deck_current_if_checked
      flash[:success] = 'Deck was successfully updated.'
      redirect_to @deck
    else
      render :edit
    end
  end

  def destroy
    @deck.destroy
    flash[:success] = 'Deck was successfully destroyed.'
    redirect_to decks_path
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end

  def make_deck_current_if_checked
    # current_user.assign_current_deck(params[:current], @deck)
    @deck.assign_current_deck(params[:current])
  end
end
