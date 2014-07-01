Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/linkedin/callback', to: 'linkedin_registration#create'
  namespace :twilio do
    get '/main-twilio', to: 'base#index'
    post '/main-twilio', to: 'base#create'
  end
end
