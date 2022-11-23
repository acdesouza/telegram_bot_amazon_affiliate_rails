class Telegram::Message
  include ActiveModel::API

  attr_accessor :id,
                :text,
                :chat_id,
                :sender_name,
                :is_bot

  def to_reply
    {
      reply_to_message_id: id
    }
  end
end
