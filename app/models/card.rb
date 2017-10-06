# Model for keeping card data.
class Card < ApplicationRecord
  before_validation(on: :create) { self.review_date = Time.now + 3.days }
  validates :original_text, :translated_text, :review_date, presence: true
  validate :not_the_same
  scope :review_date_over, ->{ where("review_date < ?", Time.now) }
  scope :latest_first, ->{ order(review_date: :asc) }
  scope :random_card, ->{ where("RANDOM()<0.01").first }

  # check that original and translated field aren't the same
  def not_the_same
    return unless original_text.casecmp(translated_text).zero?
    errors.add(:original_text, " and translated text shouldn't be equal.")
  end

  # set review date 3 days after selected date
  def arrange_review_date(date)
    update_attribute(:review_date, (date + 3.days))
  end

  # remove leading and trailing spaces, case insensitive,
  # compare translation with original text
  def check_translation(translation)
    original_text.casecmp(translation.strip).zero?
  end
end
