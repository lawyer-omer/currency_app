Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get "home/manage" => "home/manage"
  get "home/currencyrates" => "home/currencyrates"
  post "home/manage" => "home/manage"
  post "home/currencyrates" => "home/currencyrates"
end
