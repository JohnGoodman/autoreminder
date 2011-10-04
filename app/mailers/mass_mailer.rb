class MassMailer < ActionMailer::Base
  def mass_email( store, email, person, bcc, files=[], preview = nil, from_person = nil )
    @store = store
    @email = email
    @person = person
    to = @person.name + "<" + @person.email + ">"
    to = preview unless preview.blank?

    # attach files
    files.each do |file|
      attachments[file.original_filename] = File.read(file.tempfile)
    end

    mail(
      :to => to,
      :subject => email.subject,
      :from => "#{@store.name} <#{@store.email}>",
      :bcc => bcc
    )
  end

  def thank_you_email( store, email_body, email_subject, person, from_person = nil )
    @email_body = email_body
    @person = person
    @store = store
    to = @person.name + "<" + @person.email + ">"

    mail(
      :to => to,
      :subject => email_subject,
      :from => "#{@store.name} <#{@store.email}>"
    )
  end
end