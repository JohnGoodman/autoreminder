class Admin::CompaniesController < ApplicationController
  before_filter :authenticate_person!
  layout 'admin'

  set_tab :company_show, :subnav, :only => :show
  set_tab :company_new, :subnav, :only => :new
  set_tab :company_edit, :subnav, :only => :edit
  set_tab :company_mass_reminders, :subnav, :only => :mass_assign_service_reminders

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to(admin_company_path(@company), :notice => 'Company was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(admin_company_path(@company), :notice => 'Company was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @company = Company.find(params[:id]).destroy

    redirect_to(admin_companies_path)
  end

  def mass_assign_service_reminders
    @company = Company.find(params[:id])
    @service_reminders = ServiceReminder.admin_reminders
  end

  def assign_service_reminders
    @company = Company.find(params[:id])
    notice = nil
    alert = nil
    success = false
    assigned_count = 0

    if params[:company][:reminders]
      # loop them, create new reminders based off the default
      params[:company][:reminders].each do |reminder|
        if ServiceReminder.exists?(reminder)
          service_reminder = ServiceReminder.find(reminder).clone
          service_reminder.company = @company
          if service_reminder.save
            @company.assinged_reminder_to_stores(service_reminder)
            assigned_count += 1
          end
        end
      end
      notice = assigned_count.to_s + " Service Reminder(s) assigned."
      success = true
    else
      alert = 'Error: No service reminders were selected.'
    end

    respond_to do |format|
      if success
        format.html { redirect_to(admin_company_path(@company), :notice => notice) }
      else
        format.html { render :action => "mass_assign_service_reminders", alert => alert }
      end
    end
  end
end
