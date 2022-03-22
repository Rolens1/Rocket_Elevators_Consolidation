class LeadsController < ApplicationController

    require 'uri'
    # require 'net/http'
    # require 'httparty'
    # include HTTPARTY

    # require 'Freshdesk'
    # Freshdesk.domain = ENV['FRESHDESK_API']
    # Freshdesk.user_name_or_api_key = ENV['FRESHDESK_API_KEY']
    # Freshdesk.password_or_x = "X"



    def new
        @lead = Lead.new
    end

    # POST /leads
    def create
      @lead = Lead.new(lead_params)
      # if @lead.save
      #   puts "saved!"
      # else
      #   puts @lead.errors
      # end
 
      respond_to do |format|
        if @lead.save
          format.html  { redirect_to root_path, notice: 'Your message has been successfully sent!' }

          # uri = URI('https://rocketelevatorsai.freshdesk.com/api/v2/tickets')
          # HTTP.post(uri, 
          #   {:headers => 'application/json'}, 
          #   {:body => body})

         
          # body = {
          # :field => @lead.full_name.to_s,
          # :message => @lead.email.to_s
          # }.to_json
          
          # params = {:apikey => '4sLFHNBFyVFxpEN3Z' }

          # res = NET::HTTP.post_form(
          #   uri,
          #   :header => {
          #     :apikey => '4sLFHNBFyVFxpEN3Z'
          #   },
          #   :body => {
          #   'name' => @lead.full_name,
          #   'email' => @lead.email
          # })
          
          # uri = URI('https://rocketelevatorsai.freshdesk.com/api/v2/tickets')
          # req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
          # req.body = {param1: 'some value', param2: 'some other value'}.to_json
          # res = Net::HTTP.start(uri.hostname, uri.port) do |http|
          #   http.request(req)
          # puts res.body if res.is_a?(Net::HTTPSuccess)
          # Freshdesk::API::Ticket.create_a_ticket({
          #   "name": @lead.full_name,
          #   "email": @lead.email,
          #   "phone": @lead.phone,
          #   "subject": "Contact Request: " + @lead.project_name,
          #   "description": @lead.message,
          #   "type": "Question"
          # })
          tickets_conn = Freshdesk::Tickets.new({
            :apikey => ENV["FRESHDESK_API_KEY"],
            :domain => ENV["FRESHDESK_API"],
          })
      

          if @lead.full_name == nil
            @lead.full_name = "n/a"
          end
          if @lead.cie_name == nil
            @lead.cie_name = "n/a"
          end
          if @lead.email == nil
            @lead.email = "n/a"
          end
          if @lead.phone == nil
            @lead.phone = "n/a"
          end
          if @lead.project_name == nil
            @lead.project_name = "n/a"
          end
          if @lead.project_description == nil
            @lead.project_description = "n/a"
          end
          if @lead.department_in_charge == nil
            @lead.department_in_charge = "n/a"
          end
          if @lead.message == nil
            @lead.message = "n/a"
          end
          if @lead.attached_files == nil
            @lead.attached_files = "n/a"
            has_attachment = "not"  
          else
            has_attachment = ""
          end
        
          data = {
            "status": 2, 
            "priority": 1,
            "name": @lead.full_name, 
            "phone": @lead.phone,
            "email": @lead.email,
            "description": 
              "The contact" + @lead.full_name + " from company " + @lead.cie_name + " can be reached at email " + @lead.email + " and at phone number " + @lead.phone + ". " + @lead.department_in_charge + " has a project named " + @lead.project_name + " which would require contribution from Rocket Elevators. The project description is " + @lead.project_description + ". Attached message: " + @lead.message + ". The Contact has " + has_attachment + " uploaded an attachment.",
            "type": "Question",
            "subject": @lead.full_name + " from " + @lead.cie_name,
          }
          
          
          tickets_conn.create(options = {headers: 'multipart/form-data'}, body = data)

          format.json  { render json: Lead.create(lead_params) }
        else
          format.html  { redirect_to root_path, notice: 'Your message was not sent successfully.' }
          format.json  { render :json => @lead.errors, :status => :unprocessable_entity }
        end
      end

   end
  
  def lead_params
    params.require(:lead).permit(:full_name, :cie_name, :email, :phone, :project_name, :project_description, :department_in_charge, :message, :attached_files,)
  end

end