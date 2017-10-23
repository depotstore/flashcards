# Model for keeping deck data.
class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  validates :name, presence: true

  def assign_current_deck(checked)
    return if user.current_deck_id && user.current_deck_id != id &&
              checked != 'on' && checked.to_i != 1
    deck_id = checked == 'on' || checked.to_i == 1 ? id : nil
    user.update_attribute(:current_deck_id, deck_id)
  end

end
