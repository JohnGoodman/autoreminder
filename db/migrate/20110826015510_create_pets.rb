class CreatePets < ActiveRecord::Migration
  def self.up
    create_table :pets do |t|
      t.references :person
      t.string :name
      t.boolean :unsubscribe
      t.timestamps
    end
  end

  def self.down
    drop_table :pets
  end
end
