class AddCompanyTypeIdToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :company_type_id, :integer
  end

  def self.down
    remove_column :companies, :company_type_id
  end
end
