require "test_helper"

class AmazonAffiliateComposerTest < ActiveSupport::TestCase
  test "should convert dp links" do
    original_url = "https://www.amazon.com.br/Jameson-Whisky-750ml/dp/B07FPW95CM/"

    assert_equal ["#{original_url}?linkCode=batata&tag=batata"], AmazonAffiliateComposer.extract("Please, convert #{original_url}")
  end

  test "should convert dp links with parametes" do
    original_url = "https://www.amazon.com.br/Positivo-Casa-Inteligente-Movimentos-Bidirecional/dp/B09V6N8W48/?_encoding=UTF8&pf_rd_p=52e74d21-088e-4a9d-888d-8b14bf95d4ae&pd_rd_wg=sxZSs&pf_rd_r=K720RCRJACB6ZZFF8W1A&content-id=amzn1.sym.52e74d21-088e-4a9d-888d-8b14bf95d4ae&pd_rd_w=5HO3P&pd_rd_r=c8efec04-e2c1-4839-8b20-874e501e3553&ref_=pd_gw_crs_zg_bs_16243796011"

    assert_equal ["#{original_url}&linkCode=batata&tag=batata"], AmazonAffiliateComposer.extract("Please, convert #{original_url}")
  end

  test "should convert music unlimited links" do
    original_url = "https://www.amazon.com.br/music/unlimited"

    assert_equal ["#{original_url}?linkCode=batata&tag=batata"], AmazonAffiliateComposer.extract("Please, convert #{original_url}")
  end

  test "should convert music unlimited links with already present affiliate tag" do
    original_url = "https://www.amazon.com.br/music/unlimited?amp%3B&amp%3BlinkId=0199b7f750a04a1243168459d4fb4eec&amp%3Blanguage=pt_BR&amp%3Bref_=as_li_ss_tl&_encoding=UTF8&linkId=7506f6f62a8694f168a2324f2cab87c7&camp=1789&creative=9325"
    expected_url = "https://www.amazon.com.br/music/unlimited?linkId=0199b7f750a04a1243168459d4fb4eec&language=pt_BR&ref_=as_li_ss_tl&_encoding=UTF8&linkId=7506f6f62a8694f168a2324f2cab87c7&camp=1789&creative=9325&linkCode=batata&tag=batata"

    assert_equal [expected_url], AmazonAffiliateComposer.extract("Please, convert #{original_url}")
  end

  test "should convert search links" do
    original_url = "https://www.amazon.com.br/s?bbn=16957239011&rh=n%3A17095685011&language=pt_BR&_encoding=UTF8&brr=1&content-id=amzn1.sym.4bce92ac-7c24-478b-ba34-7a42a6b7cc1b&pd_rd_r=4b113817-7146-4f5d-9c6a-b0e0861899f5&pd_rd_w=R3Oyp&pd_rd_wg=rhrKy&pf_rd_p=4bce92ac-7c24-478b-ba34-7a42a6b7cc1b&pf_rd_r=6RCV2FEWEGGDBGZBW1QZ&rd=1&ref=Oct_d_odnav_d_17095642011_9"

    assert_equal ["#{original_url}&linkCode=batata&tag=batata"], AmazonAffiliateComposer.extract("Please, convert #{original_url}")
  end

  # TODO Request shorten URLs
  test "should convert shorten links" do
    skip
    original_url = "https://a.co/d/88xaxKm"

    assert_equal ["#{original_url}&linkCode=batata&tag=batata"], AmazonAffiliateComposer.extract("Please, convert #{original_url}")
  end
end
