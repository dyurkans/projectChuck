ProjectChuck::Application.routes.draw do
  
  get "households/new"
  get "students/index" 

  # Generated routes
  resources :students
  resources :households
  resources :guardians
  resources :teams
  resources :registrations
  resources :brackets
  resources :users
  resources :tournaments
  


  
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
    
  # add custom routes for certain actions
  get 'teams/:id/remove' => 'teams#remove_student', :as => :remove_student  
  get 'brackets/:id/remove' => 'brackets#remove_team', :as => :remove_team
  get 'teams/:id/add' => 'teams#add_student', :as => :add_student  
  get 'brackets/:id/add' => 'brackets#add_team', :as => :add_team


  # Set the root url
  root :to => 'home#index'
end
