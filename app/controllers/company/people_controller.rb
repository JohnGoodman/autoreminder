class Company::PeopleController < ApplicationController
  before_filter :authenticate_person!
  layout 'company'

  set_tab :people, :subnav, :only => :index
  set_tab :person_new, :subnav, :only => [:new, :create]
  set_tab :person_edit, :subnav, :only => [:edit, :update]

  def index
    # @people = Person.not_customers
    @people = @company.people.gm_store_employees(current_user.store_ids)
  end

  def new
    @person = Person.new
    @stores = current_user.stores
  end

  def edit
    @person = Person.find(params[:id])
    @stores = current_user.stores
  end

  def create
    @person = Person.new(params[:person])
    @person.online_access = true
    @person.company = @company
    @person.role = Role.find(3)

    respond_to do |format|
      if @person.save
        format.html { redirect_to(company_people_path, :notice => 'Person was successfully created.') }
      else
        @stores = current_user.stores
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(company_people_path, :notice => 'Person was successfully updated.') }
      else
        @stores = current_user.stores
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
        format.html { redirect_to(company_root_path, :notice => 'Profile was successfully updated.') }
      else
        format.html { render :action => "edit_profile" }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id]).destroy
    redirect_to(company_people_path)
  end
end
