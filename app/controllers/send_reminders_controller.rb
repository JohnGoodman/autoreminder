class SendRemindersController < ApplicationController
  skip_before_filter :authenticate_person!
  skip_before_filter :get_store

  layout nil

  def index
    # Setup the uploaded files
    # uploaded_files = []
    # if params[:email][:attachments]
    #   params[:email][:attachments].each do |attachment|
    #     uploaded_files << attachment
    #   end
    # end
    #
    # recurring_count = 0
    # recurring_reminders = SendReminders.find_recurring_reminders
    #
    # appointment_count = 0
    # appointment_reminders = SendReminders.find_appointment_reminders
    #
    # recurring_reminders.each do |reminder|
    #   ReminderMailer.recurring_reminder( reminder ).deliver
    #   recurring_count += 1
    # end
    #
    # appointment_reminders.each do |reminder|
    #   ReminderMailer.appointment_reminder( reminder ).deliver
    #   appointment_count += 1
    # end
    #
    # @reminders = recurring_reminders
    # @a_reminders = appointment_reminders
    @reminders = nil
    @a_reminders = nil

  end
end