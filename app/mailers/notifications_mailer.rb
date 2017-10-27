class NotificationsMailer < ApplicationMailer

  def pending_cards(user)
    number = user.cards.review_date_over.count
    word = 'card'.pluralize(number)
    @message = "Hi, you have #{number} overdue #{word}!"
    mail(to: user.email, subject: "overdue #{word}")
  end
end
