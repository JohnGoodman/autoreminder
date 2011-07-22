class Vehicle < ActiveRecord::Base
  belongs_to :person
  has_many :customer_service_reminders

  attr_accessible :person_id, :year, :make, :model, :email

  validates_presence_of     :make
  validates_presence_of     :model
  validates_presence_of     :year
  validates_presence_of     :email

  def name
    [year, make, model].join(" ")
  end
end
