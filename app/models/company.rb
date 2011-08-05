class Company < ActiveRecord::Base
  has_many :stores

  def store_type
    office ? 'Office' : 'Store'
  end
end
