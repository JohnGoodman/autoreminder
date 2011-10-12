class Company::EmailsController < ApplicationController
  before_filter :authenticate_person!
  layout 'company'

  set_tab :email_show, :subnav, :only => :show
  set_tab :email_new, :subnav, :only => [:new, :create]
  set_tab :email_edit, :subnav, :only => [:edit, :update]

  def index
    @emails = @company.emails.templates.order('id DESC')
  end

  def new
    @email = Email.new
    @email.company = @company
    @email.person = current_user

    if @email.save(:validate => false)
      redirect_to( edit_company_email_path( @email ) )
    else
      redirect_to(:back, :notice => 'Email could not be created created.')
    end
  end

  def show
    @email = Email.find(params[:id])
  end

  def edit
    @email = Email.find(params[:id])
    @stores = current_user.stores
  end

  def update
    @email = Email.find(params[:id])
    path = company_emails_path
    notice = nil # 'Email was successfully updated.'
    alert = nil
    success = false

    if params[:save] || params[:save_send]
      @email.template = true
    end

    if @email.update_attributes(params[:email])
      success = true
      notice = 'Email was successfully updated.'
    end

    # Setup the uploaded files
    uploaded_files = []
    if params[:email][:attachments]
      params[:email][:attachments].each do |attachment|
        uploaded_files << attachment
      end
    end

    if success && ( params[:send] || params[:save_send] )
      bcc = nil
      email_count = 0

      # loop store customers
      @company.customers(params[:store_ids], true, true).each do |customer|
        # Send the email
        email_count += 1 if MassMailer.mass_email( customer.store, @email, customer, bcc, uploaded_files ).deliver
      end
      success = true
      notice = email_count.to_s + " Emails successfully sent."
    end

    if params[:preview]
      preview_store = Store.find(params[:store_ids].first)
      if MassMailer.mass_email( preview_store, @email, current_person, bcc, uploaded_files, @email.preview_to ).deliver
        notice = 'Preview email sent to ' + @email.preview_to
      else
        alert = 'Error. Failed to send preview email.'
      end
      path = edit_company_email_path(@email)
    end

    respond_to do |format|
      if success
        format.html { redirect_to(path, :notice => notice, :alert => alert) }
      else
        @stores = current_user.stores
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @email = Email.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(company_emails_path) }
    end
  end

  def load_advertisement
    @advertisement = Email.new
    @stores = current_user.stores
  end

  def send_advertisement
    success = false
    email_count = 0

    if params[:email][:id]
      @advertisement = Email.find(params[:email][:id])
      # if params[:email][:advertisement_image].blank? && @advertisement.advertisement_image.present?
      #   params[:email][:advertisement_image] = @advertisement.advertisement_image
      # end
      saved = true if @advertisement.update_attributes(params[:email])
    else

      @advertisement = Email.new(params[:email])
      @advertisement.advertisement = true
      saved = true if @advertisement.save
    end

    if saved && params[:send]
      # Put the file into a mailer
      @company.customers(params[:store_ids], true, true).each do |customer|
        # Send the email
        email_count += 1 if MassMailer.advertisement_email( customer.store, @advertisement, customer ).deliver
      end
      success = true
    elsif saved && params[:preview]
      preview_store = Store.find(params[:store_ids].first)
      MassMailer.advertisement_email( preview_store, @advertisement, current_user, @advertisement.preview_to ).deliver
      success = false # so we render instead of redirect
      flash[:notice] = 'Preivew sent.'
    end

    # Return
    if success
      redirect_to( company_root_path, :notice => 'Advertisement successfully sent to ' + email_count.to_s + ' customers.')
    else
      @stores = current_user.stores
      # flash[:alert] = 'Error.'
      render :load_advertisement
    end
  end
end
