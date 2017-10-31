require "rails_helper"

describe SuperMemo2 do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
  let(:card) { create(:card, deck: deck, review_date: Date.today) }
  let(:super_memo) { SuperMemo2.new(card, 3) } #middle case
  let(:super_memo_q4) { SuperMemo2.new(card, 4) } #does not change ef
  let(:super_memo_q5) { SuperMemo2.new(card, 5) } #increases ef significantly
  let(:super_memo_q0) { SuperMemo2.new(card, 0) } #decreases ef significantly

  context '#arrange_review_date' do
    it 'increases repetition' do
      super_memo.arrange_review_date
      expect(card.repetition).to eql 1
    end
    it "changes interval" do
      super_memo.arrange_review_date
      expect(card.interval).to eql 1
    end
    it "changes interval according settings" do
      2.times { super_memo.arrange_review_date }
      expect(card.interval).to eql 6
    end
    it "does not change ef (E-Factor) after first repetition" do
      super_memo.arrange_review_date
      expect(card.ef).to eql 2.5
    end
    it "does not change ef (E-Factor) after second repetition" do
      2.times { super_memo.arrange_review_date }
      expect(card.ef).to eql 2.5
    end

    it "increases repetition equally number of repetition" do
      3.times { super_memo.arrange_review_date }
      expect(card.repetition).to eql 3
    end

    it "changes interval (not equal to 6) after third repetition" do
      3.times { super_memo.arrange_review_date }
      expect(card.interval).not_to eql 6
    end

    it "changes ef (E-Factor) after third repetition" do
      3.times { super_memo.arrange_review_date }
      expect(card.ef).not_to eql 2.5
    end

    it "does not set up ef (E-Factor) after many repetition more 2.5" do
      10.times { super_memo_q5.arrange_review_date }
      expect(card.ef).to be <= 2.5
    end

    it "does not set up ef (E-Factor) after many repetition less 1.3" do
      10.times { super_memo_q0.arrange_review_date }
      expect(card.ef).to be >= 1.3
    end
  end
end
