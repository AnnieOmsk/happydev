Happydev::Application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :events

  devise_for :users, :skip => [:registrations], :controllers => {:registrations => "registrations"}, :path => "registration", :path_names => { :sign_up => "new", :sign_in => 'login', :sign_out => 'logout' } do
    get 'registration/new' => 'devise/registrations#new', :as => 'new_user_registration'
    post 'registration' => 'devise/registrations#create', :as => 'user_registration'
    get 'registration/profile' => 'registrations#profile', :as => 'user_profile'
    # get '                 registration/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    # put 'registration' => 'devise/registrations#update', :as => 'user_registration'
    # delete 'registration' => 'devise/registrations#destroy', :as => 'user_registration'
  end

  resource :invoice, :only => [:new, :create, :show] do
    put :clearing
  end

  match '/about/requisites' => 'home#requisites'
  match '/programme' => 'home#program'
  match '/program' => 'home#program'
  match '/about' => 'home#about'
  match '/oferta' => 'home#oferta'
  match '/pay' => 'home#payment'

  match '/invoices/new' => 'invoices#new', :as => :pay
  # match '/speakers/:id' => 'high_voltage/pages#show', :as => :static, :via => :get, :format => false
  match '/speakers/:permalink' => 'speeches#show'

  scope 'payment' do
    match 'result'    => 'payments#result',    :as => :payment_result # to handle Robokassa push request
    match 'success' => 'payments#success', :as => :payment_success # to handle Robokassa success redirect
    match 'fail'    => 'payments#fail',    :as => :payment_fail # to handle Robokassa fail redirect
  end  

  get "home/index"
  root :to => 'home#index'
  # match ':controller(/:action(/:id))(.:format)'
end
