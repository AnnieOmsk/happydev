Happydev::Application.routes.draw do
  resources :events

  devise_for :users, :skip => [:sessions, :password, :registrations], :path => "registration", :path_names => { :sign_up => "new", :sign_in => 'login', :sign_out => 'logout' } do
    get 'registration/new' => 'devise/registrations#new', :as => 'new_user_registration'
    post 'registration' => 'devise/registrations#create', :as => 'user_registration'
    # put 'registration' => 'devise/registrations#update', :as => 'user_registration'
    # delete 'registration' => 'devise/registrations#destroy', :as => 'user_registration'
    # get 'registration/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  end

  resource :payment, :only => [:new, :create, :show] do
    post :update_amount
    # get :demopage, :on => :collection, :as => :payment_demopage
  end

  match '/about/requisites' => 'home#requisites'
  match '/about' => 'home#about'

  scope 'payment' do
    match 'result'    => 'payments#result',    :as => :payment_result # to handle Robokassa push request
    match 'success' => 'payments#success', :as => :payment_success # to handle Robokassa success redirect
    match 'fail'    => 'payments#fail',    :as => :payment_fail # to handle Robokassa fail redirect
  end  

  get "home/index"
  root :to => 'home#index'
  # match ':controller(/:action(/:id))(.:format)'
end
