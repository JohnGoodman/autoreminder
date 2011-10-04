class AddFieldsToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :thank_you_text, :text
    add_column :companies, :thank_you_subject, :string
    add_column :companies, :additional_vehicle_fields, :boolean
  end

  def self.down
    remove_column :companies, :thank_you_text
    remove_column :companies, :thank_you_subject
    remove_column :companies, :additional_vehicle_fields
  end
end
