class VehiclesController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_person

  set_tab :vehicle_new, :subnav, :only => :new

  def index
    @vehicles = @store.vehicles.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehicles }
    end
  end

  def new
    @vehicle = @person.vehicles.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vehicle }
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    @default_email = @vehicle.email
  end

  def create
    @vehicle = @person.vehicles.new(params[:vehicle])

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to(store_person_path(@store, @person), :notice => 'Vehicle was successfully created.') }
        format.xml  { render :xml => @vehicle, :status => :created, :location => @vehicle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])

    respond_to do |format|
      if @vehicle.update_attributes(params[:vehicle])
        format.html { redirect_to(store_person_path(@store, @person), :notice => 'Vehicle was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(store_person_path(@store, @person)) }
      format.xml  { head :ok }
    end
  end

  def get_person
    params[:person_id] ? @person = Person.find(params[:person_id]) : @person = Person.find(Vehicle.find(params[:id]).person_id)
  end
end
