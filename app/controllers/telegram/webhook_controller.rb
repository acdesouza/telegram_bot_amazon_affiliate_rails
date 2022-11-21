class Telegram::WebhookController < ApplicationController
  def create
    puts "-" * 50
    pp params
    sender = params[:message][:from][:first_name]
    msg    = params[:message][:text]
    answer = "Hello, #{sender}!\n Did you said: '#{msg}'?"
    puts '.' * 50
    pp answer
    puts "-" * 50
  end
end
