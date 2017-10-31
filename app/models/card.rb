# Model for keeping card data.
class Card < ApplicationRecord
  belongs_to :deck
  before_validation(on: :create) { self.review_date = Date.today }

  validates :original_text, :translated_text, :review_date, presence: true
  validates :ef, numericality: { greater_than_or_equal_to: 1.3,
                                  less_than_or_equal_to: 2.5 }
  validates :wrong_guess, numericality: { greater_than_or_equal_to: 0,
                                          less_than_or_equal_to: 3 }
  validate :not_the_same
  validate :picture_size
  scope :review_date_over, ->{ where("review_date <= ?", Date.today) }
  scope :latest, ->{ order(review_date: :asc) }
  scope :random_card, ->{ order("RANDOM()").first }
  mount_uploader :picture, PictureUploader

# assumed that distance = 1 is typo, distance greater than 1 is wrong answer
# only '<subst>' tag is typo
# book -> boko, obok - are typos, booke, ook are wrong answers
  def typo?(answer)
    return false if DamerauLevenshtein.distance(original_text, answer) > 1
    differ = DamerauLevenshtein::Differ.new
    differ.run(original_text, answer)[0].include?('<subst>')
  end

# update wrong_guess value by one
  def wrong_guess_counter
    update_attribute(:wrong_guess, wrong_guess + 1)
  end

  # check that original and translated field aren't the same
  def not_the_same
    return unless original_text.casecmp(translated_text).zero?
    errors.add(:original_text, "and translated text shouldn't be equal.")
  end

  # remove leading and trailing spaces, case insensitive,
  # compare translation with original text
  def check_translation(translation)
    original_text.casecmp(translation.strip).zero?
  end

# check that picture size less than 5MB
  def picture_size
    return unless picture.size > 5.megabytes
    errors.add(:picture, "should be less than 5MB")
  end
end
