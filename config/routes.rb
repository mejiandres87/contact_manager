require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  
  resources :contacts_files, only: [ :show, :create, :index] do 
    member do 
      post '/import', to: 'contacts_files#import_contacts_from_file'
    end
  end
  
  devise_for :users
  root 'welcome#index'
end
