class Telegram::WebhookController < ApplicationController
  def create
    chat_id = params.dig(:message, :chat, :id)
    sender  = params.dig(:message, :from, :first_name)
    is_bot  = params.dig(:message, :from, :is_bot)
    msg_id  = params.dig(:message, :message_id)
    msg     = params.dig(:message, :text)

    bot = TelegramBot.new
    if bot.should_answer?(text: msg, is_bot: is_bot)
      bot.message(chat_id: chat_id,
                  reply_to_message_id: msg_id,
                  text: bot.answer(sender: sender, text: msg))
    end
  end
end
