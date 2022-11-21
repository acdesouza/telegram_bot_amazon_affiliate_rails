class Telegram::WebhookController < ApplicationController
  def create
    puts "-" * 50
    pp params

    chat_id = params.dig(:message, :chat, :id)
    sender  = params.dig(:message, :from, :first_name)
    is_bot  = params.dig(:message, :from, :is_bot)
    msg_id  = params.dig(:message, :message_id)
    msg     = params.dig(:message, :text)

    if should_answer?(text: msg, is_bot: is_bot)
      message(chat_id: chat_id,
              reply_to_message_id: msg_id,
              text: answer(sender: sender, text: msg))
    end
  end

  private
  def message(chat_id:, reply_to_message_id:, text:)
    token  = ENV['TELEGRAM_BOT_TOKEN']
    server = ENV.fetch('TELEGRAM_API', 'https://api.telegram.org')
    sendMessageURL = URI("#{server}/bot#{token}/sendMessage")

    require 'net/http'
    res = Net::HTTP.post_form(sendMessageURL,
                              chat_id: chat_id,
                              reply_to_message_id: reply_to_message_id,
                              text: text)

    puts "_" * 50
    puts res.body
    puts "_" * 50
  end

  def answer(sender:, text:)
    answer  = "Olar, #{sender}!\n Poderia comprar por esse link? \n#{amazon_urls(text).join(",\n")}"

    puts '.' * 50
    pp answer
    puts "-" * 50

    answer
  end

  def should_answer?(text:, is_bot:)
    return text.present? &&
           !is_bot &&
           has_amazon_url?(text)
  end

  def has_amazon_url?(text)
    extracted_urls = URI.extract(text)
    extracted_urls.any? do |url|
      URI(url).hostname.match?(/amazon.com.br/)
    end
  end

  AMAZON_PRODUCT_URL = "https://www.amazon.com.br/dp"
  LINK_CODE          = ENV.fetch('AMAZON_LINK_CODE', 'batata')
  AFFILIATE_CODE     = ENV.fetch('AMAZON_AFFILIATE_CODE', 'batata')
  def amazon_urls(text)
    text.scan(/dp\/(B[0-9|A-Z]{9})/)
      .flatten
      .uniq
      .map do |product_id|
      "#{AMAZON_PRODUCT_URL}/#{product_id}?linkCode=#{LINK_CODE}&tag=#{AFFILIATE_CODE}"
    end
  end
end
