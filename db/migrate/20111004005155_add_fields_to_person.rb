class AddFieldsToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :send_mass_emails, :boolean
  end

  def self.down
    remove_column :people, :send_mass_emails
  end
end
