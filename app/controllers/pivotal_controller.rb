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

    activity = params[:activity]
    ca.author = activity[:author]
    ca.guid = activity[:id]
    ca.text = activity[:description]
    ca.date = activity[:occurred_at]
    ca.post_activity
    
    
    render nothing: true, status: 200
    
  end
end
