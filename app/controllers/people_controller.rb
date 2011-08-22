class PeopleController < ApplicationController
  before_filter :authenticate_person!

  set_tab :person_show, :subnav, :only => :show
  set_tab :person_new, :subnav, :only => [:new, :create]
  set_tab :person_edit, :subnav, :only => [:edit, :update]

  def index
    @people = @store.customers
  end

  def new
    @person = @store.people.new
    @service_reminders = @store.all_service_reminders

    if @company.use_sub_item?
      1.times do
        vehicle = @person.vehicles.build
        2.times { vehicle.customer_service_reminders.build }
      end
    else
      1.times do
        appointment = @person.appointments.build
      end
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = @store.people.new(params[:person])
    @person.role = Role.find(4) unless params[:person][:role]

    respond_to do |format|
      if @person.save
        format.html { redirect_to(store_person_path(@store, @person), :notice => 'Person was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(person_path(@person), :notice => 'Person was successfully updated.') }
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
