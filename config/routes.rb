Rails.application.routes.draw do
  
  root 'links#index'

  resources :links do
        get :shortened, on: :collection
   end

   get ':format' => 'links#shortened'
end
