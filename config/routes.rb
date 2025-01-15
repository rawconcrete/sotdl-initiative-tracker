Rails.application.routes.draw do
  root 'characters#index'

  resources :characters, only: [:create, :destroy] do
    member do
      post :toggle_acted
      post :toggle_speed  # Add this line
    end
    collection do
      post :reset_round
    end
  end
end
