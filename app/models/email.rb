class Email < ActiveRecord::Base
  belongs_to :person
  belongs_to :store
  belongs_to :company

  mount_uploader :advertisement_image, AdvertisementUploader

  validates_presence_of     :subject, :unless => :is_advertisement?
  validates_presence_of     :body, :unless => :is_advertisement?
  validates_presence_of     :preview_to, :if => :sending_preview?
  validates_presence_of     :advertisement_subject, :if => :is_advertisement?
  validates_presence_of     :advertisement_image, :if => :is_advertisement?

  attr_accessible :store, :company, :person, :subject, :preview_to, :body, :template, :save_email, :send, :preview, :advertisement_image, :advertisement_subject
  attr_accessor :preview

  scope :templates, where(:template => true)

  private
    def sending_preview?
      preview.present? && preview
    end

    def is_advertisement?
      advertisement.present?
    end
end