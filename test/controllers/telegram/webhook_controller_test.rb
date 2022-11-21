require "test_helper"

class Telegram::WebhookControllerTest < ActionDispatch::IntegrationTest
  test "should works on dp links" do
    post "/telegram", params: {
          "message" => {
            "message_id" => 146,
            "from" => {
              "is_bot" => false,
              "first_name" => "Elise",
            },
            "chat"=> {
              "id" => -1001340589038,
            },
            "text" => "Please, convert https://www.amazon.com.br/Jameson-Whisky-750ml/dp/B07FPW95CM/",
          }
        }

    assert_response :success
  end
end
