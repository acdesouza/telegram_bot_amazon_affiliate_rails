class Telegram::WebhookController < ApplicationController
  def create
    puts "-" * 50
    pp params

    chat_id = params[:message][:chat][:id]
    sender  = params[:message][:from][:first_name]
    msg_id  = params[:message][:message_id]
    msg     = params[:message][:text]
    answer  = "Hello, #{sender}!\n Did you said: '#{msg}'?"

    message(chat_id: chat_id,
            reply_to_message_id: msg_id,
            text: answer)

    puts '.' * 50
    pp answer
    puts "-" * 50
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
end
