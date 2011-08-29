class AddUsernameToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :username, :string
  end

  def self.down
    remove_column :people, :username
  end
end
