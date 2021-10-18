Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about"
    resources :items, only: [:show, :index]
    resources :addresses, except: [:show, :new]
    resources :customers, only: [:show, :update, :edit] do
      member do
      get 'unsubscribe'
      patch 'withdraw'
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
      delete 'destroy_all'
      end
    end
    resources :orders, only: [:index, :new, :show, :create] do
      collection do
      post 'comfirm'
      get 'complete'
      end
    end
  end

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :admin do
    root to: 'homes#top'
   resources :orders, only: [:show, :update]
   resources :customers, except: [:destroy, :new, :create]
   resources :genres, except: [:destroy, :new, :show]
   resources :items, except: [:destroy]
   resources :order_details, only: [:update]
  end

end
