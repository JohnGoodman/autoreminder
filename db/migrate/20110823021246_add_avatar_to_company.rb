class AddAvatarToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :avatar, :string
  end

  def self.down
    remove_column :companies, :avatar
  end
end