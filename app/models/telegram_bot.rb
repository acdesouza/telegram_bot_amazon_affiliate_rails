require 'net/http'

class TelegramBot
  TOKEN  = ENV.fetch('TELEGRAM_BOT_TOKEN', 'MISSING_BOT_ID')
  SERVER = ENV.fetch('TELEGRAM_API', 'https://api.telegram.org')

  def message(chat_id:, reply_to_message_id:, text:)
    sendMessageURL = URI("#{SERVER}/bot#{TOKEN}/sendMessage")

    res = Net::HTTP.post_form(sendMessageURL,
                              chat_id: chat_id,
                              reply_to_message_id: reply_to_message_id,
                              text: text)
  end

  def should_answer?(text:, is_bot:)
    return text.present? &&
           !is_bot &&
           AmazonAffiliateComposer.has_amazon_url?(text)
  end

  def answer(sender:, text:)
    answer  = "Olar, #{sender}!\n Poderia comprar por esse link? \n#{AmazonAffiliateComposer.extract(text).join(",\n")}"

    answer
  end

  def register_webhook(server:, drop_pending_updates: false)
    registerWebhookURL = URI("#{SERVER}/bot#{TOKEN}/setWebhook")

    res = Net::HTTP.post_form(registerWebhookURL,
                              url: "https://#{server}/telegram",
                              drop_pending_updates: drop_pending_updates)

    response = JSON.parse(res.body)

    raise "Could not register webhook for URL: \"#{server}\"" unless response['ok']
  end
end
