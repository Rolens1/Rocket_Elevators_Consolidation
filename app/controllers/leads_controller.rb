class LeadsController < ApplicationController

    require 'uri'
    require 'open-uri'
    require 'fileutils'

    def new
        @lead = Lead.new
    end

    def show
      @lead = Lead.find(params[:id])

      client = DropboxApi::Client.new(ENV["DROPBOX_OAUTH_BEARER"])
      
      #check if client folder exists and creates client folder if file does not exist
      results = client.list_folder "/Rocket-Elevators-AI-folder/"
      contentList = []
      results.entries.each do |f|
        contentList.push(f.name)
      end
      if (contentList.include? @lead.cie_name) != true
        client.create_folder "/Rocket-Elevators-AI-folder/" + @lead.cie_name
      end
      
      # puts @lead.attached_files.read()

      #extract attachments from database
      
      # puts @lead.attached_files.file.blob.filename
      # File.open("storage/test_upload.png") do |f|
      #   client.upload_by_chunks "/Rocket-Elevators-AI-folder/test_upload.png", f, :mode => :add
      # end

    end

    def edit
 
    end

    def update
      respond_to do |format|
        if @lead.update(quote_params)
          format.html { redirect_to lead_url(@lead), notice: "Lead was successfully updated." }
          format.json { render :show, status: :ok, location: @quote }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @lead.errors, status: :unprocessable_entity }
        end
      end
    end

    def connect
      

    end

    # POST /leads
    def create
      @lead = Lead.new(lead_params)
      # if @lead.save
      #   puts "saved!"
      # else
      #   puts @lead.errors
      # end
      cie = @lead.cie_name.to_s.gsub!(/\s+/, '')
      puts cie
      puts Rails.root.join('public','uploads', cie)

      # puts
      # unless File.directory?(dirname)
      #   FileUtils.mkdir_p(dirname)
      # end

      # uploaded_io = params[:lead][:attached_files]
      # File.open(Rails.root.join('public','uploads', @lead.cie_name, uploaded_io.original_filename),'wb') do |file|
      #   file.write(uploaded_io.read)
      # end

      respond_to do |format|


        if @lead.save
          format.html  { redirect_to root_path, notice: 'Your message has been successfully sent!' }

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