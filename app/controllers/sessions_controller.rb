class SessionsController < Devise::SessionsController

  private
  # Overwriting devise methods
  
  def respond_with(resource, _opts = {})
    json_response(resource)
  end

  def respond_to_on_destroy
    head :no_content
  end
end