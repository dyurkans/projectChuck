ProjectChuck::Application.routes.draw do
  

  #match 'teams/remove/:id' => 'teams#remove', :as => :remove_student

  # Generated routes
  resources :students
  resources :households
  resources :guardians
  resources :teams
  resources :registrations
  resources :brackets
  resources :users
  resources :tournaments
  
  get "households/new"
  get "students/index" 

  
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
    
  

  # Set the root url
  root :to => 'home#index'
end
