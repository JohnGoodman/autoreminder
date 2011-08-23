class CronMailer < ActionMailer::Base
  def report( count, recurring = false )
    date = Date.today
    type = recurring ? 'Recurring' : 'Appointments'

    subject = "AutoReminder Cron - #{type} - #{date} - #{count}"
    to = 'jgoodman09@gmail.com'

    mail(
      :to => to,
      :subject => subject,
      :from => "info@autoreminder.com"
    )
  end
end