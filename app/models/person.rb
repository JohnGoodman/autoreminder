class Person < ActiveRecord::Base
  belongs_to :role
  belongs_to :store
  has_many :vehicles, :dependent => :destroy
  accepts_nested_attributes_for :vehicles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :store_id, :note, :email, :role_id, :online_access, :vehicles_attributes

  # Validations
  validates_presence_of     :first_name
  validates_presence_of     :last_name
  validates_presence_of     :role_id
  validates_presence_of     :email,                   :if => :email_required?
  validates_uniqueness_of   :email,                   :if => :email_required?
  validates_presence_of     :password,                :if => :password_required?
  validates_presence_of     :password_confirmation,   :if => :password_required?
  validate                  :password_valid?,         :if => :password_required?
  validates_presence_of     :store,                   :if => :store_required?

  def role?(check_role)
    role.name == check_role.to_s
  end

  def name
    [first_name, last_name].join ' '
  end

  def role_name
    role.name
  end

  def find_store_id
    store.id if store
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
      role && role?(:store)
    end

end
