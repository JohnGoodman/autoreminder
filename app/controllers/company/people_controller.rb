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
    redirect_to(company_root_path)
  end

  #################################### Customers #############################################

  def customer_index
    @people = params[:search] ? @company.search(params[:search], current_user.store_ids) : []
  end

  def search
    @people = params[:search] ? @company.search(params[:search], current_user.store_ids) : []
    @searching = true
    render :customer_index
  end

  def customer_new
    @form_path = "customer_create"
    @person = Person.new
    @service_reminders = @company.service_reminders

    if @company.company_type_id == 1
      1.times do
        vehicle = @person.vehicles.build
        @company.service_reminders.count.times { vehicle.customer_service_reminders.build }
      end

    elsif @company.company_type_id == 2
      1.times do
        pet = @person.pets.build
        @company.service_reminders.count.times { pet.customer_service_reminders.build }
      end

    elsif @company.company_type_id == 3
      1.times do
        appointment = @person.appointments.build
      end
    end
  end

  def customer_show
    @person = Person.find(params[:id])
  end

  def customer_edit
    @form_path = "customer_update"
    @person = Person.find(params[:id])
    @store = @person.store
    @service_reminders = @store.all_service_reminders
  end

  def customer_create
    @store = Store.find(params[:person][:store_id])
    @person = @store.people.new(params[:person])
    @person.role = Role.find(4) unless params[:person][:role]
    @person.company = @company

    respond_to do |format|
      if @person.save
        format.html { redirect_to(customer_index_company_people_path, :notice => 'Person was successfully created.') }
      else
        @form_path = "customer_create"
        format.html { render :action => "customer_new" }
      end
    end
  end

  def customer_update
    @person = Person.find(params[:id])
    @store = @person.store

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(customer_show_company_person_path(@person), :notice => 'Person was successfully updated.') }
      else
        @form_path = "customer_update"
        format.html { render :action => "customer_edit" }
      end
    end
  end

end
