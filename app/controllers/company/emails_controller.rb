class Company::EmailsController < ApplicationController
  before_filter :authenticate_person!
  layout 'company'

  def index

  end

end