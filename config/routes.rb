Happydev::Application.routes.draw do
  resources :events

  devise_for :users

  resource :payment, :only => [:new, :create] do
    # get :demopage, :on => :collection, :as => :payment_demopage
  end


  scope 'payment' do
    match 'result'    => 'payments#result',    :as => :payment_result # to handle Robokassa push request
    match 'success' => 'payments#success', :as => :payment_success # to handle Robokassa success redirect
    match 'fail'    => 'payments#fail',    :as => :payment_fail # to handle Robokassa fail redirect
  end  

  get "home/index"
  root :to => 'home#index'
  # match ':controller(/:action(/:id))(.:format)'
end
