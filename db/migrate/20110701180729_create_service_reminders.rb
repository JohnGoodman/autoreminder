class CreateServiceReminders < ActiveRecord::Migration
  def self.up
    create_table :service_reminders do |t|
      t.references :store

      t.string :name
      t.text :description
      t.string :email_subject
      t.text :email_body

      t.timestamps
    end
  end

  def self.down
    drop_table :service_reminders
  end
end
