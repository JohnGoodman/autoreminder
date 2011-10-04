class Company::VehiclesController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_person
  layout 'company'

  set_tab :vehicle_new, :subnav, :only => :new

  def new
    @vehicle = @person.vehicles.new
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    @default_email = @vehicle.email
  end

  def create
    @vehicle = @person.vehicles.new(params[:vehicle])
    @vehicle.current_milage = @vehicle.milage_at_signup unless @vehicle.milage_at_signup.blank?

    if @vehicle.save
      redirect_to(customer_show_company_person_path(@person), :notice => 'Vehicle was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])

    if @vehicle.update_attributes(params[:vehicle])
      redirect_to(store_person_path(@store, @person), :notice => 'Vehicle was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id]).destroy
    redirect_to(customer_show_company_person_path(@person))
  end

  def get_person
    params[:person_id] ? @person = Person.find(params[:person_id]) : @person = Person.find(Vehicle.find(params[:id]).person_id)
  end
end
