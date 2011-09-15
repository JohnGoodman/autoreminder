class Store < ActiveRecord::Base
  belongs_to :company
  has_many :people
  has_many :service_reminders
  has_many :customer_service_reminders, :through => :service_reminders
  has_many :vehicles, :through => :customer_service_reminders
  has_many :emails
  has_and_belongs_to_many :general_managers, :class_name => 'Person'

  attr_accessible :company_id, :name, :address, :address_two, :phone, :phone_two, :email, :fax, :city, :state, :zip

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone
  validates_presence_of :email

  def search( search )
    search = search.split(/\s/).map { |t| "%#{t}%" }
    customers.where(
      { :first_name.matches_any => search } |
      { :last_name.matches_any => search } |
      { :email.matches_any => search }
    ).order('last_name')
  end

  def all_service_reminders
    ServiceReminder.where(:id => 1) + service_reminders
  end

  def customers
    people.where(:role_id => Role.find_by_name('customer'))
  end

  def assign_company_reminders
    # Loop the companies reminders, clone and save to the store
    company.service_reminders.each do |reminder|
      new_reminder = reminder.clone
      new_reminder.company = nil
      new_reminder.store = self
      new_reminder.save
    end

  end

  # def use_set_dates?
  #     company.reminder_type_id == 2 # 2 for dates
  #   end
  #
  #   def use_sub_item?
  #     company.sub_item_title.present?
  #   end

  # def type
  #     company.office ? 'Office' : 'Store'
  #   end

end
