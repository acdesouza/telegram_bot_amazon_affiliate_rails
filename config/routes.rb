Rails.application.routes.draw do
  post '/telegram', to: 'telegram/webhook#create'
end
