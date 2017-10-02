# Model for keeping card data.
class Card < ApplicationRecord
  before_validation { self.review_date = Time.now + 3.days }
  validates :original_text, :translated_text, :review_date, presence: true
  validate :not_the_same

  # check that original and translated field aren't the same
  def not_the_same
    if self.original_text.downcase == self.translated_text.downcase
      errors.add(:original_text, " and translated text shouldn't be equal.")
    end
  end
end
