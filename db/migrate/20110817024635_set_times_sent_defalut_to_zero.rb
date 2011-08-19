class SetTimesSentDefalutToZero < ActiveRecord::Migration
  def self.up
    change_column :customer_service_reminders, :times_sent, :integer, :default => 0
    change_column :customer_service_reminders, :max_send, :integer, :default => 1
  end

  def self.down
    change_column :customer_service_reminders, :times_sent, :integer
    change_column :customer_service_reminders, :max_send, :integer
  end
end
