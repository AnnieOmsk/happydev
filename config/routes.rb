Happydev::Application.routes.draw do
  get "payment/demopage"

  devise_for :users

  scope 'payment' do
    match 'result'    => 'payment#result',    :as => :payment_result # to handle Robokassa push request
    match 'success' => 'payment#success', :as => :payment_success # to handle Robokassa success redirect
    match 'fail'    => 'payment#fail',    :as => :payment_fail # to handle Robokassa fail redirect
  end  

  get "home/index"

  root :to => 'home#index'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
