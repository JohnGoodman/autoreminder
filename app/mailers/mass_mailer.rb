class MassMailer < ActionMailer::Base
  def mass_email( store, email, person, bcc, files=[] )
    @store = store
    @email = email
    @person = person

    # attach files
    files.each do |file|
      attachments[file.original_filename] = File.read(file.tempfile)
    end

    mail(
      :to => @person.name + "<" + @person.email + ">",
      :subject => email.subject,
      :from => from,
      :bcc => bcc
    )
  end
end