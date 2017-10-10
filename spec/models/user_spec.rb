require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user has many cards' do
    let!(:user){ create(:user) }
    let!(:cards){ create_list(:card, 3) }

    it 'has cards' do
      user.cards << cards
      expect(user.cards.count).to eql 3
    end
  end
end
