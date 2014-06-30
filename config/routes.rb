Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/linkedin/callback', to: 'linkedin_registration#create'
  get '/main-menu', to: 'menu#index'
end
