desc "This task notifies users with pending cards."
task :notify_users => :environment do
  User.notify_users_with_pending_cards
end
