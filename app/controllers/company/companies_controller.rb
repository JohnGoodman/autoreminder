class Company::CompaniesController < ApplicationController
  before_filter :authenticate_person!
  layout 'company'

  def show
  end

  def new
  end

  # GET /companies/1/edit
  def edit

  end

  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to([:company, @company], :notice => 'Company was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
