module ApplicationHelper
  def deck_names
    current_user.decks.pluck(:name, :id)
  end

  def current_deck
    current_user.decks.find_by(id: current_user.current_deck_id)
  end

  def current_deck?(deck)
    return false if current_deck.nil?
    deck.id == current_deck.id
  end

  def current_deck_name
    current_deck&.name
  end
end
