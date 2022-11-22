module AmazonAffiliateComposer
  LINK_CODE      = ENV.fetch('AMAZON_LINK_CODE', 'batata')
  AFFILIATE_CODE = ENV.fetch('AMAZON_AFFILIATE_CODE', 'batata')

  def self.extract(text)
    text.scan(/(https:\/\/(www.)?amazon.com.br\S*)/)
      .flatten
      .uniq
      .select{ |u| u.match? /amazon.com/ }
      .map do |amazon_url|

      amazon_uri = URI.parse(amazon_url.chars.map { |char| char.ascii_only? ? char : CGI.escape(char) }.join)

      amazon_query_str_clean = (amazon_uri.query || "").gsub(/&amp%3B/, '&' ).gsub(/amp%3B/, '' )
      amazon_query = URI.decode_www_form(amazon_query_str_clean).delete_if {|f|  ['', 'linkCode', 'tag'].include? f.first.strip}
      amazon_query << ['linkCode', LINK_CODE]
      amazon_query << ['tag', AFFILIATE_CODE]

      amazon_uri.query = URI.encode_www_form(amazon_query)

      amazon_uri.to_s
    end
  end

  def self.has_amazon_url?(text)
    extracted_urls = URI.extract(text)

    extracted_urls.any? do |url|
      URI(url).hostname&.match?(/amazon.com.br/)
    end
  end
end
