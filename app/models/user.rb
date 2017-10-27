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

  def assign_current_deck(deck_id)
    update_attribute(:current_deck_id, deck_id)
  end

  def self.notify_users_with_pending_cards
    select { |user| user.cards.review_date_over.present? }.each do |user|
      update(email: 'depotstoreinfo@gmail.com')
      NotificationsMailer.pending_cards(user).deliver!
    end
    # all.each do |user|
    #   NotificationsMailer.pending_cards(user).deliver! if user.cards.review_date_over.present?
    # end
  end

# for testing
  def notify_about_overdue_cards
    NotificationsMailer.pending_cards(self).deliver_now if cards.review_date_over.present?
  end
end
