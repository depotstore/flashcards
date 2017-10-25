# Model for keeping card data.
class Card < ApplicationRecord
  belongs_to :deck
  before_validation(on: :create) do
    self.review_date = Date.today
    self.box = self.wrong_guess = 0
  end
  BOXES = [
    BOX_1 = { box: 1, review_date: 12.hours.from_now },
    BOX_2 = { box: 2, review_date: 3.days.from_now },
    BOX_3 = { box: 3, review_date: 1.week.from_now },
    BOX_4 = { box: 4, review_date: 2.weeks.from_now },
    BOX_5 = { box: 5, review_date: 1.month.from_now }
  ]
  validates :original_text, :translated_text, :review_date, presence: true
  validates :box, numericality: { greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 5 }
  validates :wrong_guess, numericality: { greater_than_or_equal_to: 0,
                                          less_than_or_equal_to: 3 }
  validate :not_the_same
  validate :picture_size
  scope :review_date_over, ->{ where("review_date <= ?", Date.today) }
  scope :latest, ->{ order(review_date: :asc) }
  scope :random_card, ->{ order("RANDOM()").first }
  mount_uploader :picture, PictureUploader

  def forward_review_date
    case box
    when 0 then update(BOX_1)
    when 1 then update(BOX_2)
    when 2 then update(BOX_3)
    when 3 then update(BOX_4)
    when 4, 5 then update(BOX_5)
    end
  end

  def backward_review_date
    case box
    when 0..2 then update(BOX_1)
    when 3 then update(BOX_2)
    when 4 then update(BOX_3)
    when 5 then update(BOX_4)
    end
    update_attribute(:wrong_guess, 0)
  end

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
