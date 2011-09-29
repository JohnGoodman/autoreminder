class Admin::ServiceRemindersController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_store
  before_filter :get_company
  layout 'admin'

  set_tab :service_reminder_new, :subnav
  # set_tab :service_reminder_edit, :subnav, :only => [:edit, :update]

  def index
    if @company
      @company = Company.find(params[:company_id])
      @service_reminders = @company.service_reminders
    else
      @service_reminders = ServiceReminder.admin_reminders
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
    if params[:company_id]
      @company = Company.find(params[:company_id])
    end
    @service_reminder = ServiceReminder.find(params[:id])
  end

  def create
    @service_reminder = ServiceReminder.new(params[:service_reminder])
    # @service_reminder.company = @store.company
    path = admin_service_reminders_path
    # if @store
    #   @service_reminder.store = @store
    #   path = admin_company_store_path(@company, @store)
    # end

    if params[:service_reminder][:company_id]
      @company = Company.find(params[:service_reminder][:company_id])
      @service_reminder.company = @company
      path = admin_company_service_reminders_path(@company, :service_reminders)
    end

    respond_to do |format|
      if @service_reminder.save
        @company.assinged_reminder_to_stores(@service_reminder) if @company
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
        format.html { redirect_to(admin_service_reminders_path, :notice => 'Service reminder was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @service_reminder = ServiceReminder.find(params[:id]).destroy

    redirect_to(:back, :notice => 'Reminder successfully deleted.')
  end

  def get_store
    if params[:store_id]
      @store = Store.find(params[:store_id])
    elsif params[:service_reminder] && params[:service_reminder][:store_id]
      @store = Store.find(params[:service_reminder][:store_id])
    end
    @company = @store.company if @store
  end

  def get_company
    return unless params[:company_id]
    @company = Company.find(params[:company_id])
  end
end
