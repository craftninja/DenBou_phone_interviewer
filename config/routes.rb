Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/linkedin/callback', to: 'linkedin_registration#create'
  get '/auth/failure', to: 'linkedin_registration#failure'
  get 'logout' => 'linkedin_registration#destroy', :as => 'logout'
  namespace :twilio do
    get '/main-menu', to: 'base#main_menu'
    post '/main-menu', to: 'base#create'
    post '/recordings', to: 'recordings#create'
    post '/secondary-menu', to: 'base#secondary_menu'
  end

  resources :users, only: [:show, :edit, :update]
  get 'users/:id/edit-phone', to: 'users#edit_phone', :as => 'edit_phone'

  resources :recordings, only: [:index]

  resource :comments, only: [:create]
end
