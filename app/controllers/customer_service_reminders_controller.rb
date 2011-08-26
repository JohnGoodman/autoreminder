class CustomerServiceRemindersController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_person
  # before_filter :get_vehicle, :only => [:create, :update]

  set_tab :customer_service_reminder_new, :subnav

  def index
    @customer_service_reminders = CustomerServiceReminder.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @customer_service_reminder = CustomerServiceReminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @customer_service_reminder = CustomerServiceReminder.new
    @service_reminders = @store.all_service_reminders
    if @company.company_type_id == 1
      @vehicle = Vehicle.find(params[:vehicle_id])
    elsif @company.company_type_id == 2
      @pet = Pet.find(params[:pet_id])
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @customer_service_reminder = CustomerServiceReminders.find(params[:id])
    @service_reminders = @store.all_service_reminders
  end

  def create
    @customer_service_reminder = CustomerServiceReminder.new(params[:customer_service_reminder])
    @customer_service_reminder.person = @person unless params[:customer_service_reminder][:vehicle_id].present?

    respond_to do |format|
      if @customer_service_reminder.save
        format.html { redirect_to(store_person_path(@store,@person), :notice => "#{@company.reminder_title} was successfully created.") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @customer_service_reminder = CustomerServiceReminder.find(params[:id])

    respond_to do |format|
      if @customer_service_reminder.update_attributes(params[:customer_service_reminder])
        format.html { redirect_to(store_person_path(@store,@person), :notice => "#{@company.reminder_title} was successfully updated.") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @customer_service_reminder = CustomerServiceReminder.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(store_person_path(@store,@person), :notice => "#{@company.reminder_title} was successfully removed.") }
      format.xml  { head :ok }
    end
  end

  def get_person
    @person = Person.find(params[:person_id])
  end

  # def get_vehicle
  #     if params[:vehicle_id]
  #       @vehicle = Vehicle.find(params[:vehicle_id])
  #     elsif params[:id] && CustomerServiceReminder.find(params[:id]).vehicle_id.present?
  #       Vehicle.find(CustomerServiceReminder.find(params[:id]).vehicle_id)
  #     end
  #   end
end
