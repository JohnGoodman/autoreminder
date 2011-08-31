class Email < ActiveRecord::Base
  belongs_to :person
  belongs_to :store, :through => :person

  attr_accessible :person, :subject, :preview_to, :body, :template
  attr_accessor :save, :send, :preview

  validates_presence_of     :subject
  validates_presence_of     :body
  validates_presence_of     :preview_to, :if => :sending_preview?

  private
    def sending_preview?
      preview.present? && preview
    end
end