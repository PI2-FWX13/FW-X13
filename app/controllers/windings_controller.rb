class WindingsController < ApplicationController
  before_action :set_winding, only: [:show, :edit, :update, :destroy]

  # GET /windings
  # GET /windings.json
  def index
    @windings = Winding.all
  end

  # GET /windings/1
  # GET /windings/1.json
  def show
  end

  # GET /windings/new
  def new
    @winding = Winding.new
  end

  # GET /windings/1/edit
  def edit
  end

  # POST /windings
  # POST /windings.json
  def create
    @winding = Winding.new(winding_params)

    respond_to do |format|
      if @winding.save
        format.html { redirect_to @winding, notice: 'Winding was successfully created.' }
        format.json { render :show, status: :created, location: @winding }
      else
        format.html { render :new }
        format.json { render json: @winding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /windings/1
  # PATCH/PUT /windings/1.json
  def update
    respond_to do |format|
      if @winding.update(winding_params)
        format.html { redirect_to @winding, notice: 'Winding was successfully updated.' }
        format.json { render :show, status: :ok, location: @winding }
      else
        format.html { render :edit }
        format.json { render json: @winding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /windings/1
  # DELETE /windings/1.json
  def destroy
    @winding.destroy
    respond_to do |format|
      format.html { redirect_to windings_url, notice: 'Winding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_winding
      @winding = Winding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def winding_params
      params.require(:winding).permit(:length, :radius, :offset, :filamentWidth, :filamentLength, :gelPot, :density, :layers, :angle, :windingdate)
    end
end
