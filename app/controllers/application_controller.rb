class ApplicationController < ActionController::Base
  before_filter :authenticate_person!
  before_filter :get_store
  protect_from_forgery

  def current_user
    current_person
  end

  def root
    if current_user.role? :admin
      redirect_to admin_root_path
    elsif current_user.role? :store
      redirect_to store_people_path(current_user.store)
    elsif current_user.role? :office
      redirect_to office_people_path
    end
  end

  def get_store
    return unless current_user
    if current_user.role?(:store) || current_user.role?(:office)
      @store = current_user.store
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
