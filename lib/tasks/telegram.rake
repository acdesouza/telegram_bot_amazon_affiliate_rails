namespace :telegram do

  namespace :webhooks do
    desc "This task register a webhook on Telegram API for the current TELEGRAM_BOT_TOKEN"
    task :register  => :environment do
      bot = TelegramBot.new
      bot.register_webhook(server: ENV.fetch('HEROKU_URL', ''))
    end
  end
end
