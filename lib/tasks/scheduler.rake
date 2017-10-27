desc "This task is called by the Heroku and send notifies for users"
task notify_users: :environment do
  User.notify_users_with_pending_cards
end
