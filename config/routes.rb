Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/linkedin/callback', to: 'linkedin_registration#create'
end
