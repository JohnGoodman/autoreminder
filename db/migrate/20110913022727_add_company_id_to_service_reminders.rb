class AddCompanyIdToServiceReminders < ActiveRecord::Migration
  def self.up
    add_column :service_reminders, :company_id, :integer
  end

  def self.down
    remove_column :service_reminders, :company_id
  end
end
