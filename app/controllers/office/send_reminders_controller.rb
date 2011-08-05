class Office::SendRemindersController < ApplicationController
  skip_before_filter :authenticate_person!
  skip_before_filter :get_store

  layout nil

  def index
    @reminders = SendReminders.find_reminders
  end
end