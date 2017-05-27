Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects, only: %i(index create update destroy), shallow: true do
        resources :tasks, only: %i(create update destroy) do
          resources :comments, only: %i(index create update destroy)
        end
      end

      resources :attachments, only: %i(create)

      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
