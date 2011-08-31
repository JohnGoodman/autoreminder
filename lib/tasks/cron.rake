desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  SendReminders.find_recurring_reminders
  SendReminders.find_appointment_reminders
  # if Time.now.hour % 4 == 0 # run every four hours
  #   puts "Updating feed..."
  #   NewsFeed.update
  #   puts "done."
  # end

  # if Time.now.hour == 7 # run at midnight
  #   # User.send_reminders
  #   # SendReminders
  # end
end