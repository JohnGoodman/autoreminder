class CustomerServiceReminder < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :service_reminder
  belongs_to :person

  attr_accessible :vehicle_id, :service_reminder_id, :sent_on, :interval, :recurring, :times_sent, :max_send, :custom_name, :custom_description, :custom_email_subject, :custom_email_body, :person_id, :appointment_date, :appointment_description, :created_ata

  validates_presence_of     :interval,              :unless => :person_present?
  validates_presence_of     :service_reminder_id,   :unless => :person_present?
  validates_presence_of     :max_send,              :unless => :person_present?

  validates_presence_of     :appointment_date,      :if => :person_present?

  validates_presence_of     :custom_name,           :if => :validate_custom?
  validates_presence_of     :custom_email_subject,  :if => :validate_custom?
  validates_presence_of     :custom_email_body,     :if => :validate_custom?

  def last_sent
    times_sent && times_sent > 0 ? updated_at.strftime( '%b %d, %Y') : "Not sent yet"
  end

  protected
    def validate_custom?
      service_reminder_id == 1 # If its a custom service reminder
    end

    def person_present?
      appointment_date.present?
    end
end
