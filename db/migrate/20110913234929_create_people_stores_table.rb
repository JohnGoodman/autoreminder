class CreatePeopleStoresTable < ActiveRecord::Migration
  def self.up
    create_table :people_stores, :id => false do |t|
      t.integer :person_id
      t.integer :store_id
    end
  end

  def self.down
    drop_table :people_stores
  end
end