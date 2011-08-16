class AddSubItemToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :sub_item_title, :string
    add_column :companies, :store_title, :string
    add_column :companies, :reminder_type_id, :integer
  end

  def self.down
    remove_column :companies, :sub_item_title
    remove_column :companies, :store_title
    remove_column :companies, :reminder_type_id
  end
end
