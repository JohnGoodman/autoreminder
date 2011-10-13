class PeopleController < ApplicationController
  before_filter :authenticate_person!

  set_tab :person_show, :subnav, :only => :show
  set_tab :person_new, :subnav, :only => [:new, :create]
  set_tab :person_edit, :subnav, :only => [:edit, :update]

  def index
    @people = params[:search] ? @store.search(params[:search]) : []
  end

  def search
    @people = params[:search] ? @store.search(params[:search]) : []
    @searching = true
    render :index
  end

  def new
    @person = @store.people.new
    @service_reminders = @store.all_service_reminders

    if @company.company_type_id == 1
      1.times do
        vehicle = @person.vehicles.build
        @store.service_reminders.count.times { vehicle.customer_service_reminders.build }
      end

    elsif @company.company_type_id == 2
      1.times do
        pet = @person.pets.build
        @store.service_reminders.count.times { pet.customer_service_reminders.build }
      end

    elsif @company.company_type_id == 3
      1.times do
        appointment = @person.appointments.build
      end
    elsif @company.company_type_id == 4
      1.times do
        general_reminder = @person.general_reminders.build
      end
    end

  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
    @service_reminders = @store.all_service_reminders
  end

  def edit_profile
    @person = Person.find(params[:id])
  end

  def update_profile
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        sign_in(@person, :bypass => true)
        format.html { redirect_to(store_people_path(@store), :notice => 'Profile was successfully updated.') }
      else
        format.html { render :action => "edit_profile" }
      end
    end
  end

  def create
    @person = @store.people.new(params[:person])
    @person.role = Role.find(4) unless params[:person][:role]
    @person.company = @store.company

    respond_to do |format|
      if @person.save
        format.html { redirect_to(store_people_path(@store), :notice => 'Person was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(store_person_path(@store, @person), :notice => 'Person was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(store_people_path(@store)) }
    end
  end
end
