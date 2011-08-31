class PeopleController < ApplicationController
  before_filter :authenticate_person!

  set_tab :email_show, :subnav, :only => :show
  set_tab :email_new, :subnav, :only => [:new, :create]
  set_tab :email_edit, :subnav, :only => [:edit, :update]

  def index
    @emails = @store.emails.templates
  end

  def new
    @email = Emails.new
  end

  def show
    @email = Email.find(params[:id])
  end

  def edit
    @email = Email.find(params[:id])
  end

  def create
    @email = current_user.emails.new(params[:email])

    respond_to do |format|
      if @email.save
        format.html { redirect_to(store_emails_path(@store), :notice => 'Email was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @email = Email.find(params[:id])
    path = store_email_path(@store, @email)
    notice = nil # 'Email was successfully updated.'
    alert = nil
    success = false

    # First, save the email
    if @email.update_attributes(params[:email])
      # See if the email is being sent, saved, or previewed
      if params[:email][:save]
        success = true
        notice = 'Email was successfully updated.'

      elsif params[:email][:preview]

      elsif params[:email][:send]

      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to(store_email_path(@store, @email), :notice => notice, :alert => alert) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @email = Email.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(store_emails_path(@store)) }
    end
  end
end
