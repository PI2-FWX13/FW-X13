class MachineSettingsController < ApplicationController
  before_action :set_machine_setting, only: [:show, :edit, :update, :destroy]

  # GET /machine_settings
  # GET /machine_settings.json
  def index
    @machine_settings = MachineSetting.all
  end

  # GET /machine_settings/1
  # GET /machine_settings/1.json
  def show
  end

  # GET /machine_settings/new
  def new
    @machine_setting = MachineSetting.new
  end

  # GET /machine_settings/1/edit
  def edit
  end

  # POST /machine_settings
  # POST /machine_settings.json
  def create
    @machine_setting = MachineSetting.new(machine_setting_params)

    respond_to do |format|
      if @machine_setting.save
        flash[:success] = 'Machine setting was successfully created'
        redirect_to machine_setting_path(@machine_setting.id)
      else
        format.html { render :new }
        format.json { render json: @machine_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machine_settings/1
  # PATCH/PUT /machine_settings/1.json
  def update
    respond_to do |format|
      if @machine_setting.update(machine_setting_params)
        flash[:success] = 'Machine setting was successfully updated'
        redirect_to machine_setting_path(@machine_setting.id)
      else
        format.html { render :edit }
        format.json { render json: @machine_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_settings/1
  # DELETE /machine_settings/1.json
  def destroy
    @machine_setting.destroy
    respond_to do |format|
      format.html { redirect_to machine_setting_index_path, notice: 'Machine setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine_setting
      @machine_setting = MachineSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_setting_params
      params.require(:machine_setting).permit(:maximum_offset, :maximum_size_mandril, :maximum_size_radius)
    end
end
