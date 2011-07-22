class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :address_two
      t.string :phone
      t.string :phone_two
      t.string :email
      t.string :fax
      t.string :city
      t.string :state
      t.integer :zip

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
