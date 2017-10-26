desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  User.notify_users_with_pending_cards
  puts "done."
end
