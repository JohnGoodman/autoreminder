class AddAppointmentDateToCustomerServiceReminder < ActiveRecord::Migration
  def self.up
    add_column :customer_service_reminders, :appointment_date, :datetime
    add_column :customer_service_reminders, :appointment_description, :string
  end

  def self.down
    remove_column :customer_service_reminders, :appointment_date
    remove_column :customer_service_reminders, :appointment_description
  end
end
