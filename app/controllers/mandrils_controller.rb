class MandrilsController < ApplicationController
  before_action :set_mandril, only: [:edit, :update]

  # GET /mandrils/1/edit
  def edit
  end

  # PATCH/PUT /mandrils/1
  # PATCH/PUT /mandrils/1.json
  def update
    respond_to do |format|
      if @mandril.update(mandril_params)
        format.html { redirect_to new_winding_path(@mandril.mandril_type), notice: 'Mandril was successfully updated.' }
        format.json { render :show, status: :ok, location: @mandril }
      else
        format.html { render :edit }
        format.json { render json: @mandril.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mandril
      @mandril = Mandril.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mandril_params
      params.require(:mandril).permit(:compriment, :radius, :mandril_type)
    end
end
