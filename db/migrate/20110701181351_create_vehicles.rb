class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.references :person

      t.integer :year
      t.string :make
      t.string :model
      t.string :email
      t.boolean :unsubscribe

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
