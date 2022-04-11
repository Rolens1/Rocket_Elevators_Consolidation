class InterventionsController < ApplicationController
  before_action :set_intervention, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ index show edit update destroy ]

  # GET /interventions or /interventions.json
  def index
    @interventions = Intervention.all
    @customers = Customer.all
    @users = User.all
    @buildings = Building.all
    @batteries = Battery.all
    @columns = Column.all
    @elevators = Elevator.all
    @employees = Employee.all
    
  end

  # GET /interventions/1 or /interventions/1.json
  def show
    @intervention = Intervention.find(params[:id])
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
  end

  # GET /interventions/1/edit
  def edit
  end
  

  # POST /interventions or /interventions.json
  def create
    @intervention = Intervention.new(intervention_params)

    respond_to do |format|
      if @intervention.save
        @intervention.author = current_user
        
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully created." }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interventions/1 or /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1 or /interventions/1.json
  def destroy
    @intervention.destroy

    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def get_buildings_by_customer
    @buildings = Building.where("customer_id = ?", params[:customerID])
    respond_to do |format|
      format.json { render :json => @buildings }
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def intervention_params
      # params.fetch(:intervention, {:customerID,:buildingID,:})
      params.require(:intervention).permit(:customerID, :buildingID,:batteryID, :columnID,:elevatorID,:employeeID,:result,:report,:status)
    end
end
