class GithubController < ApplicationController
  def post
    ca = CrisplyApi.new subdomain: params[:subdomain], 
                        apikey: params[:apikey]

    logger.debug params[:commits]

    params[:commits].each do |commit|
      ca.author = commit[:author][:email]
      ca.guid = commit[:id]
      ca.text = commit[:message]
      ca.date = commit[:timestamp]
      ca.post_activity
    end
    
    render nothing: true, status: 200
  end
end
