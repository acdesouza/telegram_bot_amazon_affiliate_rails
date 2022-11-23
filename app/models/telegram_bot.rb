require 'net/http'

class TelegramBot
  TOKEN  = ENV.fetch('TELEGRAM_BOT_TOKEN', 'MISSING_BOT_ID')
  SERVER = ENV.fetch('TELEGRAM_API', 'https://api.telegram.org')

  def reply_to(message:)
    if should_answer? message
      message(answer(message), message.chat_id, reply_to_msg: message)
    end
  end

  def message(text, chat_id, reply_to_msg:)
    sendMessageURL = URI("#{SERVER}/bot#{TOKEN}/sendMessage")

    res = Net::HTTP.post_form sendMessageURL,
                              {
                                chat_id: chat_id,
                                text: text
                              }.merge(reply_to_msg&.to_reply)
  end

  def should_answer?(msg)
    return msg.text.present? &&
           !ActiveModel::Type::Boolean.new.cast(msg.is_bot) &&
           AmazonAffiliateComposer.has_amazon_url?(msg.text)
  end

  def answer(msg)
    answer  = "Olar, #{msg.sender_name}!\nPoderia comprar por esse link?\n\n#{AmazonAffiliateComposer.extract(msg.text).join(",\n")}"

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
