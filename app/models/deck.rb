class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  validates :name, presence: true

# if checkbox is checked and current deck is different from calling deck
# makes it false
  def check_and_falsify(check_box_data)
    return unless check_box_data.to_i == 1
    Deck.where("current = ? AND id != ?", true, self.id).update_all(current: false)
  end

end
