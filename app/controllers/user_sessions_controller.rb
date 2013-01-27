class UserSessionsController < Devise::SessionsController
  layout 'welcome'

  def new
    resource = build_resource(nil, :unsafe => true)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  def create
    resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
end
