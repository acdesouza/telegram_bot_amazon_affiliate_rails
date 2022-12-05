require "test_helper"

class Telegram::BotTest < ActiveSupport::TestCase
  setup do
    @bot = Telegram::Bot.new
  end

  test "should convert dp links" do
    original_msg = Telegram::Message.new(
      sender_name: 'AC',
      is_bot: false,
      text: "Can you send me this link? https://www.amazon.com.br/Jameson-Whisky-750ml/dp/B07FPW95CM/"
    )
    expected_msg = "Olar, AC!\nPoderia comprar por esse link?\n\nhttps://www.amazon.com.br/Jameson-Whisky-750ml/dp/B07FPW95CM/?linkCode=batata&tag=batata"

    assert @bot.should_answer?(original_msg)
    assert_equal expected_msg, @bot.answer(original_msg)
  end

  test "should convert shorten links" do
    original_msg = Telegram::Message.new(
      sender_name: 'AC',
      is_bot: false,
      text: "Can you send me this link? https://a.co/d/bDPiQX2"
    )
    expected_msg = "Olar, AC!\nPoderia comprar por esse link?\n\nhttps://www.amazon.com.br/dp/B076HWNHL9?ref_=cm_sw_r_apin_dp_3831ZDWSHYM5K6QC1R84&linkCode=batata&tag=batata"

    assert @bot.should_answer?(original_msg)
    assert_equal expected_msg, @bot.answer(original_msg)
  end
end
