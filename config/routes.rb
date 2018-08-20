Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :lessons, except: %i[new edit]
  end
end
