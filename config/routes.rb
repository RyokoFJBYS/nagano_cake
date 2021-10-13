Rails.application.routes.draw do
  devise_for :admin
  namespace :admin do
    root to: 'homes#top'
  end
end
