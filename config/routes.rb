Rails.application.routes.draw do
  devise_for :users
  
  
  resources :posts do
    member do
      get 'like', :to => 'posts#like'
      delete 'unlike', :to => 'posts#unlike'
    end
  end  

   root 'posts#index'

 
end
