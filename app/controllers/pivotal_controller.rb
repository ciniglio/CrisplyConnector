class PivotalController < ApplicationController
  def post
    myCA = Class.new(CrisplyApi)
    ca = myCA.new subdomain: params[:subdomain],
                             apikey: params[:apikey]

    puts "HI LOG"
    puts params
    puts "B LOG"
    puts params[:activity]
    puts "C LOG"

    # payload = JSON.parse params[:payload]
    # payload["commits"].each do |commit|
    #   ca.author = commit["author"]["name"]
    #   ca.guid = commit["id"]
    #   ca.text = commit["message"]
    #   ca.date = commit["timestamp"]
    #   ca.post_activity
    # end
    
    render nothing: true, status: 200
    
  end
end
