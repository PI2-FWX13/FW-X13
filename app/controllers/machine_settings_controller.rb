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

    if @machine_setting.save
      flash[:success] = [""]
      flash[:success] <<'Machine setting was successfully created'
      redirect_to machine_setting_path(@machine_setting.id)
    else
      flash[:error] = [""]
      @machine_setting.errors.messages.each do |key, array|
        flash[:error] << "#{key} #{array[0]}"
      end
      redirect_to machine_setting_new_path
    end
  end

  # PATCH/PUT /machine_settings/1
  # PATCH/PUT /machine_settings/1.json
  def update
    if @machine_setting.update(machine_setting_params)
      flash[:success] = [""]
      flash[:success] << 'Machine setting was successfully updated'
      redirect_to machine_setting_path(@machine_setting.id)
    else
      flash[:error] = [""]
      @machine_setting.errors.messages.each do |key, array|
        flash[:error] << "#{key} #{array[0]}"
      end
      redirect_to machine_setting_edit_path(@machine_setting.id)
    end
  end

  # DELETE /machine_settings/1
  # DELETE /machine_settings/1.json
  def destroy
    @machine_setting.destroy
    flash[:notice] = [""]
    flash[:notice] << 'Machine setting was successfully destroyed'
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
