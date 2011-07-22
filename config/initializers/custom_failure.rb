class CustomFailure < Devise::FailureApp
  def redirect_url
    :login
  end

  # Eliminate warden redirect (http://goo.gl/rDTA)
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
