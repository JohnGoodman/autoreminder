class Store < ActiveRecord::Base
  belongs_to :company
  has_many :people
  has_many :service_reminders
  has_many :customer_service_reminders, :through => :service_reminders
  has_many :vehicles, :through => :customer_service_reminders

  attr_accessible :company_id, :name, :address, :address_two, :phone, :phone_two, :email, :fax, :city, :state, :zip

  validates_presence_of :name

  def all_service_reminders
    ServiceReminder.where(:id => 1) + service_reminders
  end

  def customers
    people.where(:role_id => Role.find_by_name('customer'))
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
