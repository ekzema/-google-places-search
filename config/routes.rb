Rails.application.routes.draw do
  root 'businesses#index'

  resources :businesses do
    collection do
      get 'autocomplete'
      get 'result'
    end
  end

  resources :users

  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
