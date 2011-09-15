class AddCompanyIdToEmails < ActiveRecord::Migration
  def self.up
    add_column :emails, :company_id, :integer
  end

  def self.down
    remove_column :emails, :company_id
  end
end
