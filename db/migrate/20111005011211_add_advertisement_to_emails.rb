class AddAdvertisementToEmails < ActiveRecord::Migration
  def self.up
    add_column :emails, :advertisement, :boolean
    add_column :emails, :advertisement_image, :string
    add_column :emails, :advertisement_subject, :string
  end

  def self.down
    remove_column :emails, :advertisement
    remove_column :emails, :advertisement_image
    remove_column :emails, :advertisement_subject
  end
end
