class Company < ActiveRecord::Base
  has_many :stores, :dependent => :destroy
  has_many :people
  has_many :service_reminders
  has_many :emails

  validates_presence_of :name
  validates_presence_of :company_type_id

  mount_uploader :avatar, AvatarUploader

  def search( search, gm_store_ids )
    search = search.split(/\s/).map { |t| "%#{t}%" }
    customers(gm_store_ids).where(
      { :first_name.matches_any => search } |
      { :last_name.matches_any => search } |
      { :email.matches_any => search }
    ).order('last_name')
  end

  def customers(gm_store_ids, only_subscribed = false, mass_email = nil)
    if mass_email
      mass_email_sql = {:send_mass_emails => true}
    else
      mass_email_sql = {:id.gt => 0}
    end

    if only_subscribed
      Person.subscribed.where(mass_email_sql).where(:store_id => gm_store_ids, :role_id => Role.find_by_name('customer'))
    else
      Person.where(mass_email_sql).where(:store_id => gm_store_ids, :role_id => Role.find_by_name('customer'))
    end
  end

  def assinged_reminder_to_stores(reminder)
    # Loop the stores and clone the reminder to each store
    stores.each do |store|
      new_reminder = reminder.clone
      new_reminder.company = nil
      new_reminder.store = store
      new_reminder.save
    end
  end

  # Company Types
  # 1 - Automotive
  # 2 - Vet Office
  # 3 - Doctor Office
  # 4 - General

  # Singular and Plural heading helper methods
  def type
    h = case company_type_id
      when 1 then 'Automotive'
      when 2 then 'Vets Office'
      when 3 then 'Medical Office'
      when 4 then 'General'
    end
    h
  end

  def heading_s
    h = case company_type_id
      when 1 then 'Store'
      when 2 then 'Office'
      when 3 then 'Office'
      when 4 then 'Office'
    end
    h
  end

  def heading_p
    h = case company_type_id
      when 1 then 'Stores'
      when 2 then 'Offices'
      when 3 then 'Offices'
      when 4 then 'Offices'
    end
    h
  end

  def sub_s
    h = case company_type_id
      when 1 then 'Vehicle'
      when 2 then 'Pet'
      when 3 then 'Appointment'
      when 4 then 'Reminder'
    end
    h
  end

  def sub_p
    h = case company_type_id
      when 1 then 'Vehicles'
      when 2 then 'Pets'
      when 3 then 'Appointments'
      when 4 then 'Reminders'
    end
    h
  end

  def reminder_title
    h = case company_type_id
      when 1 then 'Reminder'
      when 2 then 'Reminder'
      when 3 then 'Appointment'
      when 4 then 'Reminder'
    end
    h
  end

  def reminder_title_s
    h = case company_type_id
      when 1 then 'Reminders'
      when 2 then 'Reminders'
      when 3 then 'Appointments'
      when 4 then 'Reminders'
    end
    h
  end
end
