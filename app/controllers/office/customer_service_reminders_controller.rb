class Office::CustomerServiceRemindersController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_person
  before_filter :get_vehicle

  set_tab :customer_service_reminder_new, :subnav

  def index
    @customer_service_reminders = CustomerServiceReminder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customer_service_reminders }
    end
  end

  def show
    @customer_service_reminder = CustomerServiceReminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer_service_reminder }
    end
  end

  def new
    @customer_service_reminder = @vehicle.customer_service_reminders.new
    @service_reminders = @store.all_service_reminders

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer_service_reminder }
    end
  end

  def edit
    @customer_service_reminder = @vehicle.customer_service_reminders.find(params[:id])
    @service_reminders = @store.all_service_reminders
  end

  def create
    @customer_service_reminder = @vehicle.customer_service_reminders.new(params[:customer_service_reminder])

    respond_to do |format|
      if @customer_service_reminder.save
        format.html { redirect_to(store_person_path(@store,@person), :notice => 'Customer service reminder was successfully created.') }
        format.xml  { render :xml => @customer_service_reminder, :status => :created, :location => @customer_service_reminder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer_service_reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @customer_service_reminder = CustomerServiceReminder.find(params[:id])

    respond_to do |format|
      if @customer_service_reminder.update_attributes(params[:customer_service_reminder])
        format.html { redirect_to(store_person_path(@store,@person), :notice => 'Customer service reminder was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer_service_reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer_service_reminder = CustomerServiceReminder.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(store_person_path(@store,@person)) }
      format.xml  { head :ok }
    end
  end

  def get_person
    @person = Person.find(params[:person_id])
  end

  def get_vehicle
    params[:vehicle_id] ? @vehicle = Vehicle.find(params[:vehicle_id]) : @vehicle = Vehicle.find(CustomerServiceReminder.find(params[:id]).vehicle_id)
  end
end
