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
        if @vehicle.update_attribute(:unsubscribe, true)
          success = true
        else
          alert = "Error. #{params[:person][:email]} could not be unsubscribed. Please contact your store or office directly to be unsubscribed."
        end
      end #if person
    else
      alert = 'Error. No email provided.'
    end # params present

    if success
      redirect_to(unsubscribe_success_path)
    else
      flash[:alert] = alert
      redirect_to(unsubscribe_path, :store_id => @store.id)
      # render(:unsubscribe)
    end
  end

  def unsubscribe_success

  end
end
