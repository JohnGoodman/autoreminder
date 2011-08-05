class SendReminders

  # Find all service reminders for today
  def self.find_reminders
    today = Date.today

    # Loop the reminders to see if an email needs to be sent
    # Only select reminders that have not reached thier limit
    customer_service_reminder = CustomerServiceReminder.where(:max_send.lt => :times_sent)
    reminders_for_today = customer_service_reminder.reject{|c| self.check_reminder(c, today)}

    # Send emails
  end

  # Reject reminders that do not fit the citeria
  def self.check_reminder(c, today)
    # return true = reject

    # See if it is recurring
    unless c.recurring
      # If not recurring, reject if it's times sent is 1 or more
      return true if c.times_sent || c.times_sent == 0 # if it is set, then it is not nil - aka. it has been sent once
    end

    # Get the interval
    interval = c.interval

    # The times sent multiplier adds 1 to the times sent. This lets the interval get bigger each time sent
    times_sent_multipler = c.times_sent.to_i + 1

    # Set the interval_date to the date created plus the interval amount * times sent multipler
    interval_date = c.created_at.to_date >> (interval * times_sent_multipler)

    # If the dates match, do not reject
    return true unless interval_date == today
  end

end