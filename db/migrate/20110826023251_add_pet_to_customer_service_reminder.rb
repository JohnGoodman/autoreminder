class AddPetToCustomerServiceReminder < ActiveRecord::Migration
  def self.up
    add_column :customer_service_reminders, :pet_id, :integer
  end

  def self.down
    remove_column :customer_service_reminders, :pet_id
  end
end
