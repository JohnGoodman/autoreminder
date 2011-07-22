Warden::Manager.after_set_user do |person, auth, opts|
  unless person.online_access
    auth.logout
    throw(:warden, :message => "You do not have online access.")
  end
end
