class SendReminders

  # Find all service reminders for today
  def self.find_recurring_reminders
    # CustomerMailer.deliver_welcome_message(self)
    today = Date.today

    # turn off if need be
    # SendReminders.test

    # Loop the reminders to see if an email needs to be sent
    # Only select reminders that have not reached thier limit
    recurring_reminders = CustomerServiceReminder.where('max_send > times_sent').where(:appointment_date => nil)
    recurring_reminders_for_today = recurring_reminders.reject{|c| self.check_reminder(c, today)}

    # Send emails
    count = 0
    recurring_reminders_for_today.each do |reminder|
      if ReminderMailer.recurring_reminder( reminder ).deliver
        reminder.update_attribute(:times_sent, (reminder.times_sent.to_i + 1))
        reminder.update_attribute(:sent_on, Date.today)
        count += 1
      end
    end

    # Send email about cron
    CronMailer.report(count, true).deliver

    count
  end

  def self.find_appointment_reminders
    # Get the appointment reminders
    # Send 7 days in advance
    start_datetime = ((Date.today + 6.days).to_s + " 00:00:00").to_datetime
    end_datetime = ((Date.today + 6.days).to_s + " 23:59:59").to_datetime

    appointment_reminders_7_day = CustomerServiceReminder.where(:appointment_date.gte => start_datetime, :appointment_date.lte => end_datetime, :times_sent => 0)

    CustomerServiceReminder.joins(:person).where(:appointment_date.gte => start_datetime, :appointment_date.lte => end_datetime, :times_sent => 0).where(:person => [{:unsubscribe => false} | {:unsubscribe => nil}])

    # Send 2 days in advance
    start_datetime = ((Date.today + 2.days).to_s + " 00:00:00").to_datetime
    end_datetime = ((Date.today + 2.days).to_s + " 23:59:59").to_datetime

    appointment_reminders_2_day = CustomerServiceReminder.joins(:person).where(:appointment_date.gte => start_datetime, :appointment_date.lte => end_datetime, :times_sent => 1).where(:person => [{:unsubscribe => false} | {:unsubscribe => nil}])

    appointment_reminders = appointment_reminders_2_day + appointment_reminders_7_day

    count = 0
    appointment_reminders.each do |reminder|
      if ReminderMailer.appointment_reminder( reminder ).deliver
        reminder.update_attribute(:times_sent, (reminder.times_sent.to_i + 1))
        reminder.update_attribute(:sent_on, Date.today)
        count += 1
      end
    end

    # Send email about cron
    CronMailer.report(count).deliver

    count
  end

  # Reject reminders that do not fit the citeria
  def self.check_reminder(c, today)
    # return true = reject

    # check for unsubscribed Pet
    if c.pet
      return true if c.pet.person.unsubscribe
    end

    # check for unsubscribed Vehicle
    if c.vehicle
      return true if c.vehicle.person.unsubscribe
      return true if c.vehicle.unsubscribe
    end

    dlsj

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
    # interval_date = Date.today # FOR TESTING ONLY!!!

    # If the dates match, do not reject
    return true unless interval_date == today
  end

  # test
  # def self.test
  #     recurring = CustomerServiceReminder.where(:appointment_date => nil)
  #     recurring.each do |r|
  #       interval = r.interval
  #       reset_date = Date.today << interval
  #       r.update_attribute(:created_at, reset_date)
  #       r.update_attribute(:times_sent, 0)
  #     end
  #
  #     CustomerServiceReminder.where(:appointment_date.ne => '').update_all(:appointment_date => ((Time.now - 2.days) - 12000))
  #     CustomerServiceReminder.where(:appointment_date.ne => '').update_all(:times_sent => nil)
  #   end

end