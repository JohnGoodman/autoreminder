class ServiceReminder < ActiveRecord::Base
  belongs_to :store
  belongs_to :company
  has_many :customer_service_reminders

  attr_accessible :store_id, :name, :description, :email_subject, :email_body

  validates_presence_of :name
  validates_presence_of :email_subject
  validates_presence_of :email_body

  def self.admin_reminders
    ServiceReminder.where(:store_id => nil)
  end

  def can_delete?
    customer_service_reminders.empty?
  end
end
