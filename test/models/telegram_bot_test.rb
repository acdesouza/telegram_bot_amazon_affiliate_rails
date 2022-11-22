require "test_helper"

class TelegramBotTest < ActiveSupport::TestCase
  test "should convert dp links" do
    original_msg = "Can you send me this link? https://www.amazon.com.br/Jameson-Whisky-750ml/dp/B07FPW95CM/"
    expected_msg = "Olar, AC!\nPoderia comprar por esse link?\n\nhttps://www.amazon.com.br/Jameson-Whisky-750ml/dp/B07FPW95CM/?linkCode=batata&tag=batata"

    assert TelegramBot.new.should_answer?(is_bot: false, text: original_msg)
    assert_equal expected_msg, TelegramBot.new.answer(sender: 'AC', text: original_msg)
  end

  test "should convert shorten links" do
    original_msg = "Can you send me this link? https://a.co/d/bDPiQX2"
    expected_msg = "Olar, AC!\nPoderia comprar por esse link?\n\nhttps://a.co/d/bDPiQX2?linkCode=batata&tag=batata"

    assert TelegramBot.new.should_answer?(is_bot: false, text: original_msg)
    assert_equal expected_msg, TelegramBot.new.answer(sender: 'AC', text: original_msg)
  end
end