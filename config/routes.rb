Spree::Core::Engine.add_routes do
  post '/checkout/feedback/:state' => "checkout#feedback"
  
  resources :payments, only: %i(create)
  
  namespace :api do
    namespace :v1 do
      post "ssl_wireless/initiate/:payment_method_id/", controller: 'ssl_wireless', action: :initiate
      post 'ssl_wireless/feedback'
    end
  end
end
