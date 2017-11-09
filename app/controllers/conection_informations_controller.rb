class ConectionInformationsController < ApplicationController
  before_action :set_conection_information, only: [:show, :edit, :update, :destroy]

  # GET /conection_informations
  # GET /conection_informations.json
  def index
    @conection_informations = ConectionInformation.all
  end

  # GET /conection_informations/new
  def new
    @conection_information = ConectionInformation.new
  end

  # GET /conection_informations/1/edit
  def edit
  end

  # POST /conection_informations
  # POST /conection_informations.json
  def create
    @conection_information = ConectionInformation.new(conection_information_params)

    respond_to do |format|
      if @conection_information.save
        format.html { redirect_to conection_information_index_path, notice: 'Conection information was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: conection_information_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conection_informations/1
  # PATCH/PUT /conection_informations/1.json
  def update
    respond_to do |format|
      if @conection_information.update(conection_information_params)
        format.html { redirect_to conection_information_index_path, notice: 'Conection information was successfully updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: conection_information_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conection_informations/1
  # DELETE /conection_informations/1.json
  def destroy
    @conection_information.destroy
    respond_to do |format|
      format.html { redirect_to conection_information_index_path, notice: 'Conection information was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conection_information
      @conection_information = ConectionInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conection_information_params
      params.require(:conection_information).permit(:name, :ip)
    end
end
