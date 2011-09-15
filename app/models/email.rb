class Email < ActiveRecord::Base
  belongs_to :person
  belongs_to :store
  belongs_to :company

  validates_presence_of     :subject
  validates_presence_of     :body
  validates_presence_of     :preview_to, :if => :sending_preview?

  attr_accessible :store, :company, :person, :subject, :preview_to, :body, :template, :save_email, :send, :preview
  attr_accessor :preview

  scope :templates, where(:template => true)

  private
    def sending_preview?
      preview.present? && preview
    end
end