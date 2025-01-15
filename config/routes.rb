Rails.application.routes.draw do
  root 'characters#index'

  resources :characters, only: [:index, :create, :destroy] do
    member do
      post 'toggle_acted'
      post 'toggle_speed'
      post 'apply_damage'
      post 'apply_bonus_hp'
      post 'remove_bonus_hp'
    end

    collection do
      post 'reset_round'
    end
  end
end
