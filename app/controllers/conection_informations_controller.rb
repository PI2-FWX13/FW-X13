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
    if @conection_information.wifi_name && @conection_information.password
      set_wifi(@conection_information)

      if @conection_information.save
        current_connection(@conection_information)
        puts 'Viu as parada'
      end
      redirect_to conection_information_connect_path(@conection_information)
    else
     #do something
    end
  end

  def validate_connection(conection_information)
    #a = Random.rand(11)
    #render json: a
    #192.168.25.11
    login = 'pi'
    password = 'raspberry'
    puts 'AGORA VAI\n\n'
    if conection_information.ip_wifi
      begin
        puts "tururu"

        puts conection_information.ip_wifi
        Timeout::timeout(10) {
          server = Net::SSH.start(conection_information.ip_wifi, login, :password => password,:number_of_password_prompts => 0, :non_interactive => true)

        }
        puts "deu certo PORRA"
        return true
      rescue => ex
        flash[:error] = "Wifi Connection Failed"
      end
    end
      puts "ssadasdasda"
      begin
        Timeout::timeout(10) {
          puts "QQQQQQQ"
          server = Net::SSH.start(conection_information.ip_cable, login, :password => password,:number_of_password_prompts => 0, :non_interactive => true)
        }
        puts "deu certo PORRA 2"

        return true
      rescue => ex
        flash[:error] = "Cable Connection Failed"
        return false
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

  def connect
    if(@current_connection == nil)
      puts "ESTA NYLO"
      @conection_information = ConectionInformation.find_by_id(params[:id])
    else
      puts "NAO ESTA NULO"
      @conection_information = @current_connection
    end
    puts @conection_information.ip_wifi
    puts "^^^^^^^"
    if validate_connection(@conection_information)
      if current_connection(@conection_information)
        flash[:success] = 'Connection was made successfully'
        #redirect_to conection_information_connect_path(@conection_information)
      else
        flash[:error] = 'Connection cannot be made'
        redirect_to conection_information_index_path
      end

    end
  end

  def set_wifi(conection_information)
    begin
        Timeout::timeout(15) {
          login = 'pi'
          password = 'raspberry'
          puts 'Vai conectar'
          puts @conection_information.ip_cable
          Net::SSH.start(@conection_information.ip_cable, login, :password => password) do |ssh|
            puts 'Conectou'
            #ssh.exec! 'sudo su'
            puts 'Conectou 1'

            result = ssh.exec! "sudo echo -e 'network={ \n    ssid=" + '"' + @conection_information.wifi_name + '"' + " \n    psk=" + '"' + @conection_information.password + '"' + "\n }' >> /etc/wpa_supplicant/wpa_supplicant.conf"
            puts result
            ssh.exec! 'sudo wpa_cli -i wlan0 reconfigure'
            puts 'Conectou 3'
            result = ssh.exec! "sudo ifconfig wlan0 | grep 'inet addr' | cut -d ':' -f 2 | cut -d ' ' -f 1"
            @conection_information.ip_wifi = result
            puts @conection_information.ip_wifi
            current_connection(@conection_information)
            puts 'Fez a bagaça AAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
            puts result
          end
        }
    rescue => ex
        flash[:error] = "First Cable Connection Filed"
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conection_information
      @conection_information = ConectionInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conection_information_params
      params.require(:conection_information).permit(:name, :ip_cable, :ip_wifi, :wifi_name, :password)
    end
end
