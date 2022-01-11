Rails.application.routes.draw do
  resources :contacts_files, only: [ :show, :create, :index]
  devise_for :users
  root 'welcome#index'
end
