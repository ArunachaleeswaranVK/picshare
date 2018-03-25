Rails.application.routes.draw do
  
  get 'profiles/show'

  devise_for :users
  
  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end
  
  unauthenticated do
    devise_scope :user do
      root to: "devise/sessions#new"
    end
  end
  
  
  resources :posts do
    resources :comments
    member do
      
      get 'like', :to => 'posts#like'
      delete 'unlike', :to => 'posts#unlike'
    end
  end  

  
  
  get 'tags/:tag' , to: 'posts#index' , as: :tag
  get ':id', to: 'profiles#show', as: :profile
  
end
