class SuperMemo2
  attr_reader :ef, :interval, :repetition, :q
  # After each repetition assess the quality of repetition response in 0-5 grade scale:
  # 5 - perfect response
  # 4 - correct response after a hesitation
  # 3 - correct response recalled with serious difficulty
  # after first wrong answer only this
  # 2 - incorrect response; where the correct one seemed easy to recall
  # 1 - incorrect response; the correct one remembered
  # after third wrong answer quality automaticaly = 0
  # 0 - complete blackout.
  #  At the moment of introducing an item into a SuperMemo database, its E-Factor was assumed to equal 2.5.
  def initialize(card, quality = 4)
   @card = card
   @ef = card.ef # default 2.5 in db
   @repetition = card.repetition # default 1 in db
   @q = quality.to_i  #4 for new item does not change anything
   @interval = card.interval # default 1 in db assumed that card will be reviewed 1 day after entring to db
  end

  def arrange_review_date
    @repetition += 1 #repetition should be increased before calling calculate_interval
    @card.wrong_guess = 0 if @card.wrong_guess > 3
    calculate_interval
    @card.update(review_date: Date.today + @interval,
                 ef: @ef, interval: @interval,
                 repetition: @repetition,
                 wrong_guess: @card.wrong_guess)
  end

# the following formula to calculate inter-repetition intervals:
# I(1):=1 set as default on db level
# I(2):=6
# for n>2 I(n):=I(n-1)*EF ,where:
# I(n) - inter-repetition interval after the n-th repetition (in days)
# EF - easiness factor reflecting the easiness of memorizing and retaining
# a given item in memory (later called the E-Factor).
# n = repetition
  def calculate_interval
    if @repetition == 1 #one repetition
      @interval = 1
    elsif @repetition == 2 #two repetitions
      @interval = 6
    else
      calculate_e_factor
      @interval = @interval * @ef #repetition after second
    end
  end
# In order to calculate the new value of an E-Factor,
# the student has to assess the quality of his response to the question
# asked during the repetition of an item (my SuperMemo programs use the 0-5 grade scale
# - the range determined by the ergonomics of using the numeric key-pad).
# EF':=f(EF,q)
# EF':=EF+(0.1-(5-q)*(0.08+(5-q)*0.02))
# EF':=EF-0.8+0.28*q-0.02*q*q
# Note, that for q=4 the E-Factor does not change.
# E-Factors were allowed to vary between 1.1 for the most difficult items and 2.5 for the easiest ones.
# Shortly after the first SuperMemo program had been implemented,
# I noticed that E-Factors should not fall below the value of 1.3.
  def calculate_e_factor
    return @ef if @q == 4
    @ef = @ef + (0.1 - (5 - @q) * (0.08 + (5 - @q) * 0.02))
    # If EF is less than 1.3 then let EF be 1.3.
    @ef = 2.5 if @ef > 2.5
    @ef = 1.3 if @ef < 1.3
  end
end
