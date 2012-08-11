class GithubController < ApplicationController
  def post
    ca = CrisplyApi.new subdomain: params[:subdomain], 
                        apikey: params[:apikey]

    puts "Hello Logs!!"

    puts params[:payload]

    payload = JSON.parse params[:payload]

    puts "Parsed Payload!!"

    puts payload

    puts "Bye Logs!!"

    payload["commits"].each do |commit|
      ca.author = commit["author"]["email"]
      ca.guid = commit["id"]
      ca.text = commit["message"]
      ca.date = commit["timestamp"]
      ca.post_activity
    end
    
    render nothing: true, status: 200
  end
end
