class ConectionInformationsController < ApplicationController
  before_action :set_conection_information, only: [:show, :edit, :update, :destroy, :connect]

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
    if @conection_information.save
      redirect_to conection_information_connect_path(@conection_information)
    else
      flash[:error] = [""]
      @conection_information.errors.messages.each do |key, array|
        flash[:error] << "#{key} #{array[0]}"
      end
      redirect_to conection_information_new_path
    end
  end

  # PATCH/PUT /conection_informations/1
  # PATCH/PUT /conection_informations/1.json
  def update
    respond_to do |format|
      if @conection_information.update(conection_information_params)
        flash[:notice] = 'Connection was successfully updated'
        redirect_to conection_information_index_path
      else
        format.html { render :edit }
        format.json { render json: @conection_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conection_informations/1
  # DELETE /conection_informations/1.json
  def destroy
    @conection_information.destroy
    flash[:notice] = 'Connection was successfully destroyed'
    redirect_to conection_information_index_path
  end

  def connect
    if current_connection(@conection_information)
      flash[:success] = 'Connection was made successfully'
    else
      flash[:error] = 'Connection cannot be made'
      redirect_to conection_information_index_path
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
