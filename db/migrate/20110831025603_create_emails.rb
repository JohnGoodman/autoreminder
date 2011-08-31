class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.references :person
      t.string :subject
      t.string :preview_to
      t.text :body
      t.boolean :template

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
