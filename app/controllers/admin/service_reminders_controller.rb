class Admin::ServiceRemindersController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_store
  layout 'admin'

  set_tab :service_reminder_new, :subnav, :only => :new
  set_tab :service_reminder_edit, :subnav, :only => [:edit, :update]

  def index
    @service_reminders = ServiceReminder.admin_reminders

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_reminders }
    end
  end

  def show
    @service_reminder = ServiceReminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_reminder }
    end
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
    @service_reminder = ServiceReminder.new(params[:service_reminder])
    path = admin_service_reminders_path
    if @store
      @service_reminder.store = @store
      path = admin_company_store_path(@company, @store)
    end

    respond_to do |format|
      if @service_reminder.save
        format.html { redirect_to(path, :notice => 'Service reminder was successfully created.') }
        format.xml  { render :xml => @service_reminder, :status => :created, :location => @service_reminder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @service_reminder = ServiceReminder.find(params[:id])

    respond_to do |format|
      if @service_reminder.update_attributes(params[:service_reminder])
        format.html { redirect_to(admin_service_reminders_path, :notice => 'Service reminder was successfully updated.') }
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
      format.html { redirect_to(service_reminders_url) }
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
