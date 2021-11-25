Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :links
  end

  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'api/sign_in',
      sign_out: 'api/sign_out',
      registration: 'api/registration'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
end
