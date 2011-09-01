class AddStoreIdToEmails < ActiveRecord::Migration
  def self.up
    add_column :emails, :store_id, :integer
  end

  def self.down
    remove_column :emails, :store_id
  end
end
