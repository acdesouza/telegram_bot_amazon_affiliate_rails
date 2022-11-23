class Telegram::WebhookController < ApplicationController
  def create
    bot = Telegram::Bot.new

    bot.reply_to(message: Telegram::Message.new(
                   id:          params.dig(:message, :message_id),
                   text:        params.dig(:message, :text),
                   chat_id:     params.dig(:message, :chat, :id),
                   sender_name: params.dig(:message, :from, :first_name),
                   is_bot:      params.dig(:message, :from, :is_bot)
                 ))
  end
end
