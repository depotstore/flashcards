require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe "pending_cards" do
    let(:user) { create(:user) }
    let(:mail) { NotificationsMailer.pending_cards(user) }

    it "renders the headers" do
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
