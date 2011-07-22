class DeviseCreatePeople < ActiveRecord::Migration
  def self.up
    create_table(:people) do |t|
      t.database_authenticatable :null => true
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.references :role
      t.references :store

      t.string :first_name
      t.string :last_name
      t.string :prefix
      t.boolean :online_access, :default => false
      t.text :note

      t.timestamps
    end

    # Commented out line below because email isn't required
    # add_index :people, :email,                :unique => true
    add_index :people, :reset_password_token, :unique => true
    # add_index :people, :confirmation_token,   :unique => true
    # add_index :people, :unlock_token,         :unique => true
    # add_index :people, :authentication_token, :unique => true
  end

  def self.down
    drop_table :people
  end
end
