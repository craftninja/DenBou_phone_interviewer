Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/linkedin/callback', to: 'linkedin_registration#create'
  namespace :twilio do
    get '/main-menu', to: 'base#index'
    post '/main-menu', to: 'base#create'
  end

  resources :users, only: [:show, :edit, :update]
end
