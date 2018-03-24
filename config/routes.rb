Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users
  
  
  resources :posts do
    resources :comments
    member do
      
      get 'like', :to => 'posts#like'
      delete 'unlike', :to => 'posts#unlike'
    end
  end  

  root 'posts#index'
  
  get 'tags/:tag' , to: 'posts#index' , as: :tag
  get ':id', to: 'profiles#show', as: :profile
  
end
