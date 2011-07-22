class ServiceRemindersController < ApplicationController

  set_tab :service_reminder_new, :subnav, :only => :new
  set_tab :service_reminder_edit, :subnav, :only => [:edit, :update]

  def index
    @service_reminders = @store.service_reminders.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_reminders }
    end
  end

  # GET /service_reminders/1
  # GET /service_reminders/1.xml
  def show
    @service_reminder = @store.service_reminders.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_reminder }
    end
  end

  def new
    @service_reminder = @store.service_reminders.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_reminder }
    end
  end

  def edit
    @service_reminder = ServiceReminder.find(params[:id])
  end

  def create
    @service_reminder = @store.service_reminders.new(params[:service_reminder])

    respond_to do |format|
      if @service_reminder.save
        format.html { redirect_to(store_service_reminders_path(@store), :notice => 'Service reminder was successfully created.') }
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
        format.html { redirect_to(store_service_reminders_path(@store), :notice => 'Service reminder was successfully updated.') }
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
end
