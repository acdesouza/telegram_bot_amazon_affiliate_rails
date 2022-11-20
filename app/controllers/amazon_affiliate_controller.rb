class AmazonAffiliateController < Telegram::Bot::UpdatesController
  def message
    puts "-" * 50
    pp message
    puts "-" * 50

    respond_with :message, text: "Did you say #{message}?"
  end
end
