class CreateCustomerServiceReminders < ActiveRecord::Migration
  def self.up
    create_table :customer_service_reminders do |t|
      t.references :vehicle
      t.references :service_reminder

      t.date :sent_on
      t.integer :interval
      t.boolean :recurring
      t.integer :times_sent
      t.integer :max_send
      t.string :custom_name
      t.text :custom_description
      t.string :custom_email_subject
      t.text :custom_email_body

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_service_reminders
  end
end
