Rails.application.routes.draw do
  # We create a scope and defaults format: :json
  # so that in case of an unauthorized request it does not redirect but sends 401
  scope '/', defaults: { format: :json } do
    resources :links, except: [:show]
    get '/:id', to: 'links#show'
  end

  # Map devise methods to our controllers
  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'sign_in',
      sign_out: 'sign_out',
      registration: 'registration'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
end
