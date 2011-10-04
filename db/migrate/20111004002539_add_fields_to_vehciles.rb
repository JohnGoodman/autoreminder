class AddFieldsToVehciles < ActiveRecord::Migration
  def self.up
    add_column :vehicles, :average_miles_per_year, :integer
    add_column :vehicles, :milage_at_signup, :integer
    add_column :vehicles, :current_milage, :integer
  end

  def self.down
    remove_column :vehicles, :average_miles_per_year
    remove_column :vehicles, :milage_at_signup
    remove_column :vehicles, :current_milage
  end
end
