require 'builder'
require 'httparty'
require 'time'

class CrisplyApi
  include HTTParty

  attr_accessor :subdomain, :apikey, :author, :guid, :text, :duration
  attr_reader :date
  
  def date=(date)
    @date = Time.parse(date).utc.iso8601
  end

  def initialize(options)
    @subdomain = options[:subdomain] || 'skiaec04'
    @apikey = options[:apikey] || ENV['crisply_apikey']

    # httparty init 
    # This is a problem because it's using a class
    # variable to store the subdomain, leading to
    # overwriting the subdomain when changing. Maybe solve later with 
    # Metaprogramming
    self.class.base_uri "https://#{@subdomain}.crisply.com/api"
    self.class.basic_auth @apikey, '' 
  end

  def post_activity
    raise CrisplyApiException, "Missing Author" if @author.nil?
    raise CrisplyApiException, "Missing Guid" if @guid.nil?
    raise CrisplyApiException, "Missing Text" if @text.nil?
    
    puts self.class.post("/activity_items.xml",
                    :headers => { "Content-Type" => "application/xml",
                                  "Accept" => "application/xml"},
                    :body => create_activity_xml)
  end
  
  def create_activity_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.tag! "activity-item", "xmlns" => "http://crisply.com/api/v1" do
      xml.guid @guid
      xml.text @text
      xml.author @author
      xml.date @date if @date
    end

    xml.target!
  end
  
end

class CrisplyApiException < Exception
end
