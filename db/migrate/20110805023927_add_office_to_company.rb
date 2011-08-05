class AddOfficeToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :office, :boolean
  end

  def self.down
    remove_column :companies, :office
  end
end
