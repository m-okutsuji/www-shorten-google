
$KCODE='u'
require 'rubygems'
require 'kconv'
require 'json'
require 'httpclient'
require 'open-uri'

class GoogleURLShortener
  def initialize
    @api_key="you key"
    @base_url="https://www.googleapis.com/urlshortener/v1/url?key=#{@api_key}"
  end

  def shorten_url(url)
    begin
      c = HTTPClient.new
      postdata="{'longUrl': '#{url}'}"
      response_json= c.post_content(@base_url,postdata,"content-type"=>"application/json")
      response_hash=JSON.parse(response_json)
      return response_hash['id'].to_s
    rescue Timeout::Error, StandardError =>e
      p e
    end
    return nil
  end

  def expand_url(surl)
    begin
      url="#{@base_url}&shortUrl=#{surl}"
      response_json=open(url).read
      response_hash=JSON.parse(response_json)
      return response_hash['longUrl'].to_s
    rescue Timeout::Error, StandardError =>e
      p e
    end
  end
end


