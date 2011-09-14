class Company::StoresController < ApplicationController
  before_filter :authenticate_person!
  layout 'company'

  set_tab :store_edit, :subnav, :only => [:edit, :update]
  set_tab :store_show, :subnav, :only => :show
  set_tab :store_mass_assign, :subnav, :only => :mass_assign_service_reminders

  def index
    @stores = current_user.stores.all
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

  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to(company_store_path(@store), :notice => @company.heading_s + ' was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def mass_assign_service_reminders
    @store = Store.find(params[:id])
    @service_reminders = @company.service_reminders.where(:store_id => nil)
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
        format.html { redirect_to(company_store_path(@store), :notice => 'Store was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
