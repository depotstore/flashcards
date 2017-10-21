module ApplicationHelper
  def deck_names
    current_user.decks.collect {|d| [d.name, d.id] }
  end

  def current_deck
    current_user.decks.find_by(current: true)
  end

  def current_deck_name
    current_deck.name if  current_deck
  end
end
