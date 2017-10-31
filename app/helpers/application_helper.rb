module ApplicationHelper
  def deck_names
    current_user.decks.pluck(:name, :id)
  end

  def current_deck
    current_user.decks.find_by(id: current_user.current_deck_id) if current_user
  end

  def current_deck?(deck)
    return false if current_deck.nil?
    deck.id == current_deck.id
  end

  def current_deck_name
    current_deck&.name
  end

  def underline(locale)
    'text-decoration: underline;' if locale == I18n.locale
  end

  # 5 - perfect response
  # 4 - correct response after a hesitation
  # 3 - correct response recalled with serious difficulty
  # after first wrong answer only this
  # 2 - incorrect response; where the correct one seemed easy to recall
  # 1 - incorrect response; the correct one remembered

  def positive_grade_scale
    [['perfect response', 5],
      ['correct response after a hesitation', 4],
      ['correct response recalled with serious difficulty', 3]]
  end

  def negative_grade_scale
    [['incorrect response; where the correct one seemed easy to recall', 2],
     ['incorrect response; the correct one remembered', 1]]
  end

end
