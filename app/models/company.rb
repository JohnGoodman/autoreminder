class Company < ActiveRecord::Base
  has_many :stores, :dependent => :destroy
  has_many :people
  has_many :service_reminders
  has_many :emails

  validates_presence_of :name
  validates_presence_of :company_type_id

  mount_uploader :avatar, AvatarUploader

  def customers
    Person.where(:store_id => store_ids, :role_id => Role.find_by_name('customer'))
  end

  # Company Types
  # 1 - Automotive
  # 2 - Vet Office
  # 3 - Doctor Office

  # Singular and Plural heading helper methods
  def type
    h = case company_type_id
      when 1 then 'Automotive'
      when 2 then 'Vets Office'
      when 3 then 'Doctors Office'
    end
    h
  end

  def heading_s
    h = case company_type_id
      when 1 then 'Store'
      when 2 then 'Office'
      when 3 then 'Office'
    end
    h
  end

  def heading_p
    h = case company_type_id
      when 1 then 'Stores'
      when 2 then 'Offices'
      when 3 then 'Offices'
    end
    h
  end

  def sub_s
    h = case company_type_id
      when 1 then 'Vehicle'
      when 2 then 'Pet'
      when 3 then 'Appointment'
    end
    h
  end

  def sub_p
    h = case company_type_id
      when 1 then 'Vehicles'
      when 2 then 'Pets'
      when 3 then 'Appointments'
    end
    h
  end

  def reminder_title
    h = case company_type_id
      when 1 then 'Reminder'
      when 2 then 'Reminder'
      when 3 then 'Appointment'
    end
    h
  end

  def reminder_title_s
    h = case company_type_id
      when 1 then 'Reminders'
      when 2 then 'Reminders'
      when 3 then 'Appointments'
    end
    h
  end
end
