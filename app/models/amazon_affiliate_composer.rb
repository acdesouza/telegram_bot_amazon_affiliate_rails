require 'net/http'

module AmazonAffiliateComposer
  LINK_CODE      = ENV.fetch('AMAZON_LINK_CODE', 'batata')
  AFFILIATE_CODE = ENV.fetch('AMAZON_AFFILIATE_CODE', 'batata')
  REG_EXP_AMAZON_URL = "(amazon.com.br|a.co|amzn.to)\/"

  def self.extract(text)
    text.scan(/(https:\/\/(www.)?[#{REG_EXP_AMAZON_URL}]\S*)/)
      .flatten
      .uniq
      .select{ |u| u&.match?(/#{REG_EXP_AMAZON_URL}/) }
      .map do |amazon_url|

      amazon_uri = AmazonLink.new(original_url: amazon_url)

      amazon_uri.to_s
    end
  end

  def self.has_amazon_url?(text)
    extracted_urls = URI.extract(text)

    extracted_urls.any? do |url|
      url&.match?(/#{REG_EXP_AMAZON_URL}/)
    end
  end

  class AmazonLink
    include ActiveModel::API

    attr_accessor :original_url
    attr_reader   :url

    delegate :to_s, to: :url

    def initialize(attributes = {})
      super

      @url = parse_url(original_url)
      @url = unshorten_url(@url)

      if @url.query.present?
        @url = clean_decoded_params(@url)
        @url = remove_existing_affiliation_code(@url)
      end

      @url = add_owner_affiliation_code(@url)
    end

    private
    def parse_url(url)
      URI.parse(url.chars.map { |char| char.ascii_only? ? char : CGI.escape(char) }.join)
    end

    def clean_decoded_params(amazon_uri)
      amazon_uri.tap do |uri|
        uri.query = uri.query.gsub(/&amp%3B/, '&' ).gsub(/amp%3B/, '' )
      end
    end

    def unshorten_url(amazon_uri, limit = 5)
      return amazon_uri if !shortened?(amazon_uri) || limit == 0

      response = Net::HTTP.get_response(amazon_uri)

      case response
      when Net::HTTPSuccess then
        response
      when Net::HTTPRedirection then
        unshorten_url(URI(response['location']), limit - 1)
      else
        URI(response)
      end
    end

    def shortened?(amazon_uri)
      !amazon_uri.hostname.starts_with? "www.amazon.com"
    end

    def remove_existing_affiliation_code(amazon_uri)
      amazon_uri.tap do |uri|
        amazon_query = URI.decode_www_form(uri.query).delete_if {|f|  ['', 'linkCode', 'tag'].include? f.first.strip}
        uri.query = URI.encode_www_form(amazon_query)
      end
    end

    def add_owner_affiliation_code(amazon_uri)
      amazon_uri.tap do |uri|
        amazon_query = URI.decode_www_form( (uri.query || "") )
        amazon_query << ['linkCode', LINK_CODE]
        amazon_query << ['tag', AFFILIATE_CODE]

        uri.query = URI.encode_www_form(amazon_query)
      end
    end
  end
end
