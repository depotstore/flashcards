require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe "#check_and_falsify" do
    let!(:user) { create(:user) }
    let!(:deck_1) { create(:deck, user: user, name: 'deck_1') }
    let!(:deck_2) { create(:deck, user: user, name: 'deck_2') }
    let!(:deck_3) { create(:deck, user: user, name: 'deck_3') }

    context "there is no current deck" do
      before(:each) do
        deck_1.update_attribute(:current, true)
        deck_1.check_and_falsify("1")
        deck_1.reload
      end
      it "the deck is current" do
        expect(deck_1.current?).to be true
      end
      it "another deck is not current" do
        expect(deck_2.current?).to be false
      end
      it "other deck is not current" do
        expect(deck_3.current?).to be false
      end
    end

    context "there is current deck" do
      before(:each) do
        deck_1.update_attribute(:current, true)
        deck_2.update_attribute(:current, true)
        deck_2.check_and_falsify("1")
        deck_1.reload
        deck_2.reload
      end

      it "the deck current" do
        expect(deck_2.current?).to be true
      end
      it "previous current deck is not current" do
        expect(deck_1.current?).to be false
      end
      it "other deck is not current" do
        expect(deck_3.current?).to be false
      end

      it "only the one deck is current" do
        expect(Deck.where(current: true).count).to equal 1
      end
    end

    context "current deck is not changed if check box = 0" do
      before(:each) do
        deck_1.update_attribute(:current, true)
        deck_2.check_and_falsify("0")
        deck_1.reload
        deck_2.reload
      end
      it "does not make the deck current" do
        expect(deck_2.current?).to be false
      end
      it "previous current deck is still current" do
        expect(deck_1.current?).to be true
      end
      it "other deck is not current" do
        expect(deck_3.current?).to be false
      end

      it "only the one deck is current" do
        expect(Deck.where(current: true).count).to equal 1
      end
    end
  end
end
