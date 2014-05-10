ProjectChuck::Application.routes.draw do
  
  # Generated routes
  resources :students
  resources :registrations
  resources :households
  resources :guardians
  
  resources :teams
  resources :brackets
  resources :users
  resources :tournaments
  resources :sessions
  
  get "households/new"
  get "students/index"

  
  match 'home' => 'home#index', :as => :home
  
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
      
  # add custom routes for certain actions
  get 'teams/:id/remove' => 'teams#remove_student', :as => :remove_student  
  get 'brackets/:id/remove' => 'brackets#remove_team', :as => :remove_team
  get 'teams/:id/add' => 'teams#add_student', :as => :add_student
  get 'brackets/:id/add' => 'brackets#add_team', :as => :add_team
  get 'guardians/:id/activate' => 'guardians#activate_guardian', :as => :activate_guardian
  get 'students/:id/activate' => 'students#activate', :as => :activate
  get 'home/waitlist' => 'home#waitlist', :as => :waitlist
  #get 'home' => 'home#index', :as => :home
  
  # Set the root url
  root :to => 'home#index'
end
