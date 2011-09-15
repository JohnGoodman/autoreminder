class Admin::StoresController < ApplicationController
  before_filter :authenticate_person!
  layout 'admin'
  before_filter :get_company

  set_tab :company_stores, :subnav, :only => :index
  set_tab :store_new, :subnav, :only => :new
  set_tab :company_store, :subnav, :only => :show

  def index
    @stores = @company.stores.all
  end

  def show
    @store = Store.find(params[:id])
    @service_reminders = @store.service_reminders
  end

  def new
    @store = @company.stores.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    @store = @company.stores.new(params[:store])

    respond_to do |format|
      if @store.save
        @store.assign_company_reminders
        format.html { redirect_to(admin_company_store_path(@company, @store), :notice => @company.heading_s + ' was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to(admin_company_store_path(@company, @store), :notice => @company.heading_s + ' was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @store = Store.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(admin_company_stores_path(@company)) }
    end
  end

  def mass_assign_service_reminders
    @store = Store.find(params[:id])
    @service_reminders = ServiceReminder.admin_reminders
  end

  def assign_service_reminders
    @store = Store.find(params[:store_id])
    notice = ''
    assigned_count = 0

    if params[:store][:reminders]
      # loop them, create new reminders based off the default
      params[:store][:reminders].each do |reminder|
        if ServiceReminder.exists?(reminder)
          service_reminder = ServiceReminder.find(reminder).clone
          service_reminder.store = @store
          if service_reminder.save
            assigned_count += 1
          end
        end
      end
      notice = assigned_count.to_s + " Service Reminder(s) assigned."
    else
      notice = 'Error: No service reminders were selected.'
    end

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to(admin_company_store_path(@company, @store), :notice => 'Store was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def get_company
    params[:company_id] ? @company = Company.find(params[:company_id]) : @company = Company.find(Store.find(params[:id]).company_id)
  end
end
