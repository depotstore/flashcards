class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :decks, dependent: :destroy
  has_many :cards, through: :decks
  validates :email, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  # def assign_current_deck(checked, deck)
  #   return if current_deck_id && current_deck_id != deck.id && checked != 'on' && checked.to_i != 1
  #   puts "assign_current_deck #{deck.id}"
  #   deck_id = checked == 'on' || checked.to_i == 1 ? deck.id : nil
  #   update_attribute(:current_deck_id, deck_id)
  # end
end
