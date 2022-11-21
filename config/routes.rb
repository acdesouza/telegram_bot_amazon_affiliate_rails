Rails.application.routes.draw do
  # telegram_webhook Telegram::WebhookController, :default
  # telegram_webhook AmazonAffiliateController, :default

  post '/telegram', to: 'telegram/webhook#create'
end
