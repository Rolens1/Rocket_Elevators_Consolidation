class FdService
    def initialize(intervention)
      @intervention = intervention 
    end

    def send_ticket
        require 'net/http'
        require 'uri'
        require 'json'
        uri = URI.parse("https://rocketelevators-twr.freshdesk.com/api/v2/tickets")
        request = Net::HTTP::Post.new(uri)
        request.basic_auth(ENV["pusher_app_id"], "X")
        request.content_type = "application/json"
        msg = "Msg to switch"
        request.body = JSON.dump({
          "description" => msg,
          "subject" =>"New intervention by "+ @intervention.author.to_s+ " for the building : "+ @intervention.buildingID.to_s + " with status : "+ @intervention.status.to_s,
          "email" => "support.api@rocket.com",
          "priority" => 1,
          "status" => 2,
        })
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
    end
end