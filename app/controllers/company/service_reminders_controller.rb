class Company::ServiceRemindersController < ApplicationController
  before_filter :authenticate_person!
  layout 'company'

  set_tab :service_reminder_new, :subnav, :only => :new
  set_tab :service_reminder_edit, :subnav, :only => [:edit, :update]

  def index
    @service_reminders = @company.service_reminders
  end

  def show
    @service_reminder = ServiceReminder.find(params[:id])
  end

  def new
    @service_reminder = ServiceReminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_reminder }
    end
  end

  def edit
    @service_reminder = ServiceReminder.find(params[:id])
  end

  def create
    @service_reminder = @company.service_reminders.new(params[:service_reminder])
    path = company_service_reminders_path
    if @store
      @service_reminder.store = @store
      path = company_company_store_path(@company, @store)
    end

    respond_to do |format|
      if @service_reminder.save
        format.html { redirect_to(path, :notice => 'Service reminder was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @service_reminder = ServiceReminder.find(params[:id])

    respond_to do |format|
      if @service_reminder.update_attributes(params[:service_reminder])
        format.html { redirect_to(company_service_reminders_path, :notice => 'Service reminder was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service_reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @service_reminder = ServiceReminder.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to([:company, :service_reminders]) }
      format.xml  { head :ok }
    end
  end

  def get_store
    if params[:store_id]
      @store = Store.find(params[:store_id])
    elsif params[:service_reminder] && params[:service_reminder][:store_id]
      @store = Store.find(params[:service_reminder][:store_id])
    end
    @company = @store.company if @store
  end
end
