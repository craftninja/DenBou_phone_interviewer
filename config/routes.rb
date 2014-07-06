Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/linkedin/callback', to: 'linkedin_registration#create'
  get '/auth/failure', to: 'linkedin_registration#failure'
  get 'logout' => 'linkedin_registration#destroy', :as => 'log_out'
  namespace :twilio do
    get '/main-menu', to: 'base#index'
    post '/main-menu', to: 'base#create'
    post '/recordings', to: 'recordings#create'
  end

  resources :users, only: [:show, :edit, :update]

  get 'users/:id/edit-phone', to: 'users#edit_phone', :as => 'edit_phone'
end
