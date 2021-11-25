class RegistrationsController < Devise::RegistrationsController
  # Saves user and sign_up after
  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource) if resource.persisted?

    json_response(resource)
  end
end
