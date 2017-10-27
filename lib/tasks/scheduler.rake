desc "This task is called by the Heroku scheduler add-on"
task notify_users: :environment do
  User.notify_users_with_pending_cards
end
