class MachineInformationsController < ApplicationController
  before_action :set_machine_information, only: [:show, :edit, :update, :destroy]

  # GET /machine_informations
  # GET /machine_informations.json
  def index
    @machine_informations = MachineInformation.all
  end

  # GET /machine_informations/1
  # GET /machine_informations/1.json
  def show
  end

  # GET /machine_informations/new
  def new
    @machine_information = MachineInformation.new
  end

  # GET /machine_informations/1/edit
  def edit
  end

  # POST /machine_informations
  # POST /machine_informations.json
  def create
    @machine_information = MachineInformation.new(machine_information_params)

    respond_to do |format|
      if @machine_information.save
        format.html { redirect_to @machine_information, notice: 'Machine information was successfully created.' }
        format.json { render :index, status: :created, location: @machine_information }
      else
        format.html { render :new }
        format.json { render json: @machine_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machine_informations/1
  # PATCH/PUT /machine_informations/1.json
  def update
    respond_to do |format|
      if @machine_information.update(machine_information_params)
        format.html { redirect_to @machine_information, notice: 'Machine information was successfully updated.' }
        format.json { render :show, status: :ok, location: @machine_information }
      else
        format.html { render :edit }
        format.json { render json: @machine_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_informations/1
  # DELETE /machine_informations/1.json
  def destroy
    @machine_information.destroy
    respond_to do |format|
      format.html { redirect_to machine_informations_url, notice: 'Machine information was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine_information
      @machine_information = MachineInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_information_params
      params.require(:machine_information).permit(:name, :ip)
    end
end
