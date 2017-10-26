class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.pending_cards.subject
  #
  def pending_cards(user)
    @greeting = "Hi, you have #{user.cards.review_date_over.count} overdue cards!"
    mail to: user.email
  end
end
