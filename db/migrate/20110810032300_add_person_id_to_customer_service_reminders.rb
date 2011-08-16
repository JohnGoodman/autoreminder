class AddPersonIdToCustomerServiceReminders < ActiveRecord::Migration
  def self.up
    add_column :customer_service_reminders, :person_id, :integer
  end

  def self.down
    remove_column :customer_service_reminders, :person_id
  end
end
