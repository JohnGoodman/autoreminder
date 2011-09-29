class People::SessionsController < Devise::SessionsController
  layout "login"

  def unsubscribe
    # http://localhost:3000/unsubscribe?email=faxm@example.com&sid=13
  end

  def unsubscribe_person
    success = false
    alert = nil

    if params[:person][:store_id].present? && params[:person][:email].present?
      @store = Store.find(params[:person][:store_id])
      @person = @store.people.find_by_email(params[:person][:email])
      if @person
        if @person.update_attribute(:unsubscribe, true)
          success = true
        else
          alert = "Error. #{params[:person][:email]} could not be unsubscribed. Please contact your store or office directly to be unsubscribed."
        end
      else # find Vehcilce
        @vehicle = Vehicle.find_by_email(params[:person][:email])
        if @vehicle && @vehicle.update_attribute(:unsubscribe, true)
          success = true
        else
          alert = "Error. #{params[:person][:email]} could not be unsubscribed. Please contact your store or office directly to be unsubscribed."
        end
      end #if person
    else
      if params[:person][:email].blank?
        alert = 'Error. No email provided. Please contact your store or office directly to be unsubscribed.'
      elsif params[:person][:store_id].blank?
        alert = 'Error. We could not find your store or office. Please contact your store or office directly to be unsubscribed.'
      end
    end # params present

    if success
      redirect_to(unsubscribe_success_path)
    else
      flash[:alert] = alert
      store_id = @store ? @store.id : nil
      redirect_to(unsubscribe_path, :store_id => store_id)
      # render(:unsubscribe)
    end
  end

  def unsubscribe_success

  end
end
