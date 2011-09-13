class ApplicationController < ActionController::Base
  before_filter :authenticate_person!
  before_filter :check_scope
  before_filter :get_store
  protect_from_forgery

  def current_user
    current_person
  end

  def root
    if current_user.role? :admin
      redirect_to admin_root_path
    elsif current_user.role? :company
      redirect_to company_root_path
    elsif current_user.role? :store
      redirect_to store_people_path(current_user.store)
    end
  end

  def check_scope
    if current_user
      unless ['people/sessions','application'].include?(params[:controller])
        if current_user.role? :admin
          if params[:controller].split("/")[0] != 'admin'
            flash[:alert] = 'Error. You are not allowed to access that page.'
            redirect_to admin_root_path
          end
        elsif current_user.role? :company
          if params[:controller].split("/")[0] != 'company'
            flash[:alert] = 'Error. You are not allowed to access that page.'
            redirect_to company_root_path
          end
        elsif current_user.role? :store
          redirect = false
          unless ['people','customer_service_reminders','pets','vehicles','emails'].include?(params[:controller])
            alert = 'Error. You are not allowed to access that page.'
            path = store_people_path(current_user.store)
            redirect = true
          end

          if params[:store_id].to_i != current_user.store.id.to_i
            alert = 'Error. You are not allowed to access that page.'
            path = store_people_path(current_user.store)
            redirect = true
          end

          if redirect
            flash[:alert] = alert
            redirect_to path
          end
        end # role = store
      end # include controller actions
    end # current user
  end

  def get_store
    return unless current_user
    if current_user.role?(:store)
      @store = current_user.store
      @company = @store.company
    end
  end

  private
    def sort_column
      params[:sort].present? ? params[:sort] : 'name'
    end

    def sort_direction
      params[:direction].present? ? params[:direction] : 'asc'
    end
end
