# Model for keeping card data.
class Card < ApplicationRecord
  before_validation(on: :create) { self.review_date = 3.days.from_now }
  validates :original_text, :translated_text, :review_date, presence: true
  validate :not_the_same
  scope :review_date_over, ->{ where("review_date < ?", Date.today) }
  scope :latest, ->{ order(review_date: :asc) }
  scope :random_card, ->{ order("RANDOM()").first }

  # check that original and translated field aren't the same
  def not_the_same
    return unless original_text.casecmp(translated_text).zero?
    errors.add(:original_text, "and translated text shouldn't be equal.")
  end

  # set review date 3 days after date when card was riviewed
  def arrange_review_date
    update_attribute(:review_date, 3.days.from_now)
  end

  # remove leading and trailing spaces, case insensitive,
  # compare translation with original text
  def check_translation(translation)
    original_text.casecmp(translation.strip).zero?
  end
end
