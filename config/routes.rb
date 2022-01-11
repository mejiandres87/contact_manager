Rails.application.routes.draw do
  resources :contacts_files, only: [ :show, :create, :index] do 
    member do 
      post '/import', to: 'contacts_files#import_contacts_from_file'
    end
  end
  
  devise_for :users
  root 'welcome#index'
end
