class Vehicle < ActiveRecord::Base
  belongs_to :person
  has_many :customer_service_reminders, :dependent => :destroy
  accepts_nested_attributes_for :customer_service_reminders, :reject_if => lambda { |a| a[:interval].blank? && a[:service_reminder_id].blank? }, :allow_destroy => true

  attr_accessible :person_id, :year, :make, :model, :email, :milage_at_signup, :average_miles_per_year, :current_milage, :customer_service_reminders_attributes

  validates_presence_of     :make
  validates_presence_of     :model
  validates_presence_of     :year
  validates_numericality_of :average_miles_per_year, :allow_blank => true
  validates_numericality_of :milage_at_signup, :allow_blank => true
  validates_numericality_of :current_milage, :allow_blank => true

  def name
    [year, make, model].join(" ")
  end
end
