class ReminderMailer < ActionMailer::Base
  def recurring_reminder( reminder )
    @reminder = reminder
    if reminder.vehicle.present?
      @vehicle = reminder.vehicle
      @person = @vehicle.person
      @pet = nil
      email_address = reminder.vehicle.email.present? ? reminder.vehicle.email : @person.email
    else
      @pet= reminder.pet
      @person = @pet.person
      @vehicle = nil
      email_address = @person.email
    end
    @store = reminder.service_reminder.store
    # @body = reminder.service_reminder.name == 'Custom Reminder' ? reminder.custom_email_body : reminder.service_reminder.email_body

    subject = reminder.service_reminder.name == 'Custom Reminder' ? reminder.custom_email_subject : reminder.service_reminder.email_subject

    bcc = 'jgoodman09@gmail.com'
    to = @person.name + "<" + email_address + ">"

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

    bcc = 'jgoodman09@gmail.com'
    to = @person.name + "<" + @person.email + ">"

    mail(
      :to => to,
      :subject => @reminder.service_reminder.email_subject,
      :from => "#{@store.name} <#{@store.email}>",
      :bcc => bcc
    )
  end
end