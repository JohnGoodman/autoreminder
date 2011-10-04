class Person < ActiveRecord::Base
  belongs_to :role
  belongs_to :store
  belongs_to :company
  has_and_belongs_to_many :stores
  has_many :emails
  has_many :customer_service_reminders
  has_many :vehicles, :dependent => :destroy
  accepts_nested_attributes_for :vehicles, :reject_if => lambda { |a| a[:year].blank? && a[:make].blank? && a[:model].blank? }, :allow_destroy => true

  has_many :pets, :dependent => :destroy
  accepts_nested_attributes_for :pets, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  has_many :appointments, :class_name => 'CustomerServiceReminder', :dependent => :destroy
  accepts_nested_attributes_for :appointments, :reject_if => lambda { |a| a[:interval].blank? && a[:service_reminder_id].blank? }, :allow_destroy => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :first_name, :last_name, :store_id, :note, :email, :role_id, :online_access, :vehicles_attributes, :appointments_attributes, :pets_attributes, :store_ids, :company_id, :store, :unsubscribe, :send_mass_emails

  # Validations
  validates_presence_of     :first_name
  validates_presence_of     :last_name
  validates_presence_of     :role
  validates_presence_of     :username,                :if => :email_required?
  validates_uniqueness_of   :username,                :if => :email_required?
  validates_presence_of     :password,                :if => :password_required?
  validates_presence_of     :password_confirmation,   :if => :password_required?
  validate                  :password_valid?,         :if => :password_required?
  validates_presence_of     :email
  validates_uniqueness_of   :email,                   :scope => :store, :if => :customer?
  validates_presence_of     :store_id,                :if => :store_required?

  after_create do
    return unless role_id == 4 # customer
    return unless company.thank_you_text.present? && company.thank_you_subject.present?

    # Send the thank you email
    MassMailer.thank_you_email( store, company.thank_you_text, company.thank_you_subject, self, store.manager ).deliver
  end

  def role?(check_role)
    role.name == check_role.to_s
  end

  scope :subscribed, where({:unsubscribe => nil} | {:unsubscribe => false})

  def name
    [first_name, last_name].join ' '
  end

  def reverse_name
    [last_name, first_name].join ', '
  end

  def role_name
    role.name
  end

  def find_store_id
    store.id if store
  end

  def self.not_customers
    Person.joins(:role).where(:role => {:id.ne => 4})
  end

  def self.gm_store_employees(store_ids)
    Person.joins(:role).where(:store_id => store_ids, :role => {:id => 3})
  end

  protected
    def password_required?
      if !online_access # If the person doesn't have online access, password isn't required
        false
      elsif !encrypted_password.blank? # If the person already has a pass, only validate if they are updating pass
        password.present? || password_confirmation.present?
      else # If this is the first time granting access, force password
        true
      end
    end

    def password_valid?
      return true unless password_required?
      errors.add(:password, "should contain at least one number") unless /^(?=.*\d)/.match(password)
      errors.add(:password, "should contain at least one uppercase letter") unless /^(?=.*[A-Z])/.match(password)
      errors.add(:password, "should contain at least one lowercase letter") unless /^(?=.*[a-z])/.match(password)
    end

    def email_required?
      online_access # If the person has online_access, email is required
    end

    def store_required?
      role && (role?(:store) || role?(:customer))
    end

    def customer?
      return false unless store_id.present?
      role && role?(:customer)
    end
end
