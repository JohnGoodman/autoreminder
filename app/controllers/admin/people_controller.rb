class Admin::PeopleController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_company, :except => [:edit_profile, :update_profile]
  layout 'admin'

  set_tab :people, :subnav, :only => :index
  set_tab :person_new, :subnav, :only => [:new, :create]
  set_tab :person_edit, :subnav, :only => [:edit, :update]

  def index
    # @people = Person.not_customers
    @people = @company.people.not_customers
  end

  def new
    @person = Person.new
    @stores = @company.stores
    @roles = Role.where(:id => [2,3])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(params[:person])
    @person.online_access = true
    @person.company = @company

    respond_to do |format|
      if @person.save
        format.html { redirect_to(admin_company_people_path(@company), :notice => 'Person was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(admin_company_people_path(@company), :notice => 'Person was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def edit_profile
    @person = Person.find(params[:id])
  end

  def update_profile
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        sign_in(@person, :bypass => true)
        format.html { redirect_to(admin_companies_path, :notice => 'Profile was successfully updated.') }
      else
        format.html { render :action => "edit_profile" }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(admin_company_people_path(@company)) }
    end
  end

  def get_company
    params[:company_id] ? @company = Company.find(params[:company_id]) : @company = Company.find(Store.find(params[:id]).company_id)
  end
end
