class EmailsController < ApplicationController
  before_filter :authenticate_person!

  set_tab :email_show, :subnav, :only => :show
  set_tab :email_new, :subnav, :only => [:new, :create]
  set_tab :email_edit, :subnav, :only => [:edit, :update]

  def index
    @emails = @store.emails.templates.order('id DESC')
  end

  def new
    @email = Email.new
    @email.store = @store
    @email.person = current_user

    if @email.save(:validate => false)
      redirect_to( edit_store_email_path( @store, @email ) )
    else
      redirect_to(:back, :notice => 'Email could not be created created.')
    end
  end

  def show
    @email = Email.find(params[:id])
  end

  def edit
    @email = Email.find(params[:id])
  end

  # def create
  #   @email = @store.emails.new(params[:email])
  #   @email.person = current_user
  #
  #   respond_to do |format|
  #     if @email.save
  #       format.html { redirect_to(store_emails_path(@store), :notice => 'Email was successfully created.') }
  #     else
  #       format.html { render :action => "new" }
  #     end
  #   end
  # end

  def update
    @email = Email.find(params[:id])
    path = store_emails_path(@store)
    notice = nil # 'Email was successfully updated.'
    alert = nil
    success = false

    if params[:save] || params[:save_send]
      @email.template = true
      if @email.update_attributes(params[:email])
        success = true
        notice = 'Email was successfully updated.'
      end
    end

    if params[:send] || (params[:save_send] && success)
      # Send the email

      success = true
    end

    respond_to do |format|
      if success
        format.html { redirect_to(path, :notice => notice, :alert => alert) }
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
