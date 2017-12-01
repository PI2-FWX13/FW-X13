class MandrilsController < ApplicationController
  before_action :set_mandril, only: [:edit, :update]

  # GET /mandrils/1/edit
  def edit
  end

  # PATCH/PUT /mandrils/1
  # PATCH/PUT /mandrils/1.json
  def update
    return if validate_mandril(@mandril)
    if @mandril.update(mandril_params)
      flash[:notice] = [""]
      flash[:notice] << 'Mandril was successfully updated'
      redirect_to new_winding_path(@mandril.mandril_type)
    else
      flash[:error] = [""]
      @mandril.errors.messages.each do |key, array|
        flash[:error] << "#{key} #{array[0]}"
      end
      redirect_to mandril_edit_path(@mandril.id)
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
