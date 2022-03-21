class LeadsController < ApplicationController
  
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
          format.json  { render json: Lead.create(lead_params) }
        else
          format.html  { redirect_to root_path, notice: 'Your message was not sent successfully.' }
          format.json  { render :json => @lead.errors, :status => :unprocessable_entity }
        end
      end
      # respond_to do |format|
      #   if @lead.save
      #       format.json { render :preview, status: :created, location: @lead }
      #   else
      #       format.json { render json: @lead.errors, status: :unprocessable_entity }
      #   end
      # end
   end
  
  def lead_params
    params.require(:lead).permit(:full_name, :cie_name, :email, :phone, :project_name, :project_description, :department_in_charge, :message, :attached_files,)
  end
end