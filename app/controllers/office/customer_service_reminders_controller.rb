class Office::CustomerServiceRemindersController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_person

  set_tab :customer_service_reminder_new, :subnav

  def show
    @appointment = CustomerServiceReminder.find(params[:id])
  end

  def new
    @appointment = @person.appointments.new
    @service_reminders = @store.all_service_reminders
  end

  def edit
    @appointment = @person.appointments.find(params[:id])
    @service_reminders = @store.all_service_reminders
  end

  def create
    @appointment = @person.appointments.new(params[:customer_service_reminder])

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to(office_person_path(@person), :notice => 'Appointment was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @appointment = CustomerServiceReminder.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])
        format.html { redirect_to(office_person_path(@person), :notice => 'Appointment was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @appointment = CustomerServiceReminder.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(office_person_path(@person)) }
    end
  end

  def get_person
    @person = Person.find(params[:person_id])
  end

end
