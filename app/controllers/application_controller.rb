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
        unless ['people','customer_service_reminders','pets','vehicles'].include?(params[:controller])
          flash[:alert] = 'Error. You are not allowed to access that page.'
          redirect_to store_people_path(current_user.store)
        end

        if params[:store_id].to_i != current_user.store.id.to_i
          flash[:alert] = 'Error. You are not allowed to access that page.'
          redirect_to store_people_path(current_user.store)
        end
      end
    end
  end

  def get_store
    return unless current_user
    if current_user.role?(:store) || current_user.role?(:office)
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
