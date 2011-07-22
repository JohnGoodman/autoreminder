class CustomFailure < Devise::FailureApp
  def respond
    super
    flash.keep # keep flash from being wiped out on redirect
  end
end
