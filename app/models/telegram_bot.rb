require 'net/http'

class TelegramBot
  TOKEN  = ENV.fetch('TELEGRAM_BOT_TOKEN', 'MISSING_BOT_ID')
  SERVER = ENV.fetch('TELEGRAM_API', 'https://api.telegram.org')

  def message(chat_id:, reply_to_message_id:, text:)
    sendMessageURL = URI("#{server}/bot#{token}/sendMessage")

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
end
