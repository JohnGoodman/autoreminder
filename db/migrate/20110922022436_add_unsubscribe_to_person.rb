class AddUnsubscribeToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :unsubscribe, :boolean
  end

  def self.down
    remove_column :people, :unsubscribe
  end
end
