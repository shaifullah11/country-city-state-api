Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      root 'fetch#index'
      get '/India', to: 'currency#index'
      get '/timezone', to: 'fetch#time'
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
