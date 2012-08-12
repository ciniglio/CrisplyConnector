########################################################################
##
##  Alejandro Ciniglio
##  
##  This class is best used by dynamically creating a subclass and
##  then creating an instance of that. This is a limitation of 
##  HTTParty, where if you need multiple subdomains, you need to
##  create a new class for each.
##
########################################################################


require 'builder'
require 'httparty'
require 'time'

class CrisplyApi
  include HTTParty

  attr_accessor :subdomain, :apikey, :author, :guid, :text, :duration
  attr_reader :date
  
  def date=(date)
    @date = Time.parse(date.to_s).utc.iso8601
  end

  def initialize(options)
    @subdomain = options[:subdomain] || 'skiaec04'
    @apikey = options[:apikey] || ENV['crisply_apikey']

    # httparty init 
    # This is a problem because it's using a class
    # variable to store the subdomain, leading to
    # overwriting the subdomain when changing.
    # This is solvable by subclassing this and using an
    # instance of the subclass
    # e.g. myCA = Class.new(CrisplyApi)
    #      ca = myCA.new subdomain: "AwesomeCo"
    #      # add data to ca...q
    #      ca.post_activity
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

  def base_url
    self.class.base_uri
  end
  
end

class CrisplyApiException < Exception
end
