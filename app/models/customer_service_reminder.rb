class CustomerServiceReminder < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :service_reminder

  attr_accessible :vehicle_id, :service_reminder_id, :sent_on, :interval, :recurring, :times_sent, :max_send, :custom_name, :custom_description, :custom_email_subject, :custom_email_body

  validates_presence_of     :interval
  validates_presence_of     :vehicle_id
  validates_presence_of     :service_reminder_id

  validates_presence_of     :custom_name,           :if => :validate_custom?
  validates_presence_of     :custom_email_subject,  :if => :validate_custom?
  validates_presence_of     :custom_email_body,     :if => :validate_custom?

  def last_sent
    times_sent ? updated_at : "Not sent yet"
  end

  protected
    def validate_custom?
      service_reminder_id == 1 # If its a custom service reminder
    end
end
