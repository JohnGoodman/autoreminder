class ReminderMailer < ActionMailer::Base
  def recurring_reminder( reminder )
    @reminder = reminder
    @person = reminder.vehicle.person
    @store = reminder.service_reminder.store
    # @body = reminder.service_reminder.name == 'Custom Reminder' ? reminder.custom_email_body : reminder.service_reminder.email_body

    subject = reminder.service_reminder.name == 'Custom Reminder' ? reminder.custom_email_subject : reminder.service_reminder.email_subject

    bcc = 'john@poeticsystems.com'
    # to = person.email
    # to = @person.name + "<" + @person.email + ">"
    to = 'jgoodman09@gmail.com'

    # attach files
    # files.each do |file|
    #   attachments[file.original_filename] = File.read(file.tempfile)
    # end

    mail(
      :to => to,
      :subject => subject,
      :from => "#{@store.name} <#{@store.email}>",
      :bcc => bcc
    )
  end

  def appointment_reminder( reminder )
    @reminder = reminder
    @person = reminder.person
    @store = reminder.service_reminder.store
    # @body = reminder.service_reminder.name == 'Custom Reminder' ? reminder.custom_email_body : reminder.service_reminder.email_body
    subject = reminder.service_reminder.name == 'Custom Reminder' ? reminder.custom_email_subject : reminder.service_reminder.email_subject

    bcc = 'john@poeticsystems.com'
    # to = person.email
    # to = @person.name + "<" + @person.email + ">"
    to = 'jgoodman09@gmail.com'

    mail(
      :to => to,
      :subject => @reminder.service_reminder.email_subject,
      :from => "#{@store.name} <#{@store.email}>",
      :bcc => bcc
    )
  end
end