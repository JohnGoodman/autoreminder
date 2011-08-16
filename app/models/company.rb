class Company < ActiveRecord::Base
  has_many :stores, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :store_title
  validates_presence_of :reminder_type_id

  # def store_type
  #   # office ? 'Office' : 'Store'
  #   reminder_type_id == '2' ? 'Office' : 'Store'
  # end

  # Singular and Plural heading helper methods
  def heading_s
    store_title.singularize.capitalize
  end

  def heading_p
    store_title.pluralize.capitalize
  end

  def sub_s
    sub_item_title.present? ? sub_item_title.singularize.capitalize : 'Reminder'
  end

  def sub_p
    sub_item_title.present? ? sub_item_title.pluralize.capitalize : 'Reminders'
  end

  def use_sub_item?
    sub_item_title.present?
  end

  def use_set_dates?
    reminder_type_id == 2 # 2 for dates
  end

  def reminder_type
    if reminder_type_id == 1
      type = 'Intervals'
    elsif reminder_type_id == 2
      type = 'Dates'
    end

    type
  end
end
