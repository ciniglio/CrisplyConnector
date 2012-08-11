class GithubController < ApplicationController
  def post
    ca = CrisplyApi.new subdomain: params[:subdomain], 
                        apikey: params[:apikey]

    payload = JSON.parse params[:payload]
    payload["commits"].each do |commit|
      ca.author = commit["author"]["name"]
      ca.guid = commit["id"]
      ca.text = commit["message"]
      ca.date = commit["timestamp"]
      ca.post_activity
    end
    
    render nothing: true, status: 200
  end
end
