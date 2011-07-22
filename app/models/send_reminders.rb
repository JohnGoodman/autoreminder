class SendReminders

  # Find all service reminders for today
  def self.find_reminders
    today = Date.today

    # Loop the reminders to see if an email needs to be sent
    # Only select reminders that have not reached thier limit
    customer_service_reminder = CustomerServiceReminder.where(:max_send.lt => :times_sent)
    reminders_for_today = customer_service_reminder.reject{|c| self.check_reminder(f, today)}
  end

  # Reject reminders that do not fit the citeria
  def self.check_reminder(f, today)
    # See if it is recurring

    # If not, reject if it's times sent is 1 or more

    # If it is recurring, get the interval
    # Set the interval_date to today minus the interval amount
    # If the dates match, do not reject
  end

end