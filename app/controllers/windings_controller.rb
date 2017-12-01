class WindingsController < ApplicationController
  before_action :set_winding, only: [:show, :edit, :update, :destroy, :monitor, :graph]

  require 'net/scp'
  require 'bigdecimal'
  require 'bigdecimal/util'

  # GET /windings
  # GET /windings.json
  def index
    @windings = Winding.all
    if params[:search]
      @windings = Winding.search(params[:search]).order("created_at DESC")
    else
      @windings = Winding.all.order('created_at DESC')
    end
  end

  # GET /windings/1
  # GET /windings/1.json
  def show
  end

  # GET /windings/new
  def new
    if Mandril.count == 0
      @mandril = Mandril.new(compriment: 0, radius: 0, mandril_type: params[:type])
      @mandril.save
    else
      @mandril = Mandril.first
      if @mandril.mandril_type != params[:type]
        @mandril.mandril_type = params[:type]
      end
    end
    @winding = Winding.new
  end
  # POST /windings
  # POST /windings.json
  def create
    mandril = Mandril.first
    @winding = Winding.new(winding_params)
    @winding.winding_type = mandril.mandril_type
    @winding.winding_date = Time.now
    return unless validate_winding(@winding)
    generate_gcode

    #print "WIRE NEEDED " + needed_wire
    if @winding.save
        sendgcode
      redirect_to monitor_winding_path(@winding.id)
    else
      flash[:error] = [""]
      @winding.errors.messages.each do |key, array|
        flash[:error] << "#{key} #{array[0]}"
      end
      redirect_to new_winding_path(@winding.winding_type)
    end
end

  # DELETE /windings/1
  # DELETE /windings/1.json
  def destroy
    @winding.destroy
    flash[:notice] = [""]
    flash[:notice] << 'Winding was successfully destroyed'
    redirect_to windings_path
  end

  def choose
  end

  def graph
  end

  def monitor
=begin
    thr = Thread.new {
      host = '192.168.25.12'
      #192.168.25.11
      login = 'pi'
      password = 'raspberry'

      Net::SSH.start(host, login, :password => password) do |ssh|
        while(@@current_temperature != 'END')
          output = ssh.exec!"tail -1 temperature.out"
          @@current_temperature = output

          puts "output"
          sleep
        end
      end
    }
=end
  end

  def gettemperature
    #a = Random.rand(11)
    #render json: a
    host = $current_connection.ip
    #192.168.25.11
    login = 'pi'
    password = 'raspberry'

    Net::SSH.start(host, login, :password => password) do |ssh|
      #while(@@current_temperature != 'END')
        output = ssh.exec!"tail -1 /home/pi/temperature.out"
        @@current_temperature = output
        puts @@current_temperature
        puts "output"
        #sleep
      #end
    end

    puts @@current_temperature

    render json: @@current_temperature

  end

  private

    # https://github.com/net-ssh/net-ssh
    # https://stackoverflow.com/questions/5644110/how-do-i-transfer-files-using-ssh-and-scp-using-ruby-calls
    # https://raspberrypi.stackexchange.com/questions/37920/how-do-i-set-up-networking-wifi-static-ip-address
    # scp ../sensor/get_temperature.c pi@192.168.25.12:
    def sendgcode
      #thr = Thread.new {
        begin
          host = '10.42.0.43'
          #192.168.25.11
          login = 'pi'
          password = 'raspberry'

          Net::SCP.start(host, login, :password => password) do |scp|
            puts 'SCP Started!'
            scp.upload('gcode', '/home/pi/CodigoMotorComMelhorComunicacao')
          end
        rescue Exception => e
          puts e.message
          puts e.backtrace.inspect
        end
        Net::SSH.start(host, login, :password => password) do |ssh|
          #while(@@current_temperature != 'END')
            ssh.exec!"cd /home/pi/CodigoMotorComMelhorComunicacao/ && make && make run"
            #ssh.exec!"cd ~/ && ./get_temperature"

            puts "rodando motor"
          #  sleep
          #end
        end
      #}
      thr2 = Thread.new {

        Net::SSH.start(host, login, :password => password) do |ssh|
          #while(@@current_temperature != 'END')
            #ssh.exec!"cd /home/pi/CodigoMotorComMelhorComunicacao/ && make && make run"
            ssh.exec!"cd ~/ && ./get_temperature"

            puts "rodando temp"
            #sleep
          #end
        end
      }
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_winding
      @winding = Winding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def winding_params
      params.require(:winding).permit(:project_name, :length, :radius, :offset, :filament_width, :filament_length, :gelPot, :density, :layers, :angle, :winding_date)
    end

    def generate_gcode

      camadas = @winding.layers
      a = @winding.angle
      c = @winding.length
      e = @winding.filament_width
      o = @winding.offset
      r = @winding.radius
      x = 0

      file = File.open("gcode","w+")

      radians = a * Math::PI / 180
      delay = (r + o)/ Math.tan(radians)
      if(a == 90)
        mult = 1
        l = 1
      else
        mult = (2*Math::PI*r)/(e/Math.cos(radians))
        l = (r/Math.tan(radians))*2
      end
      (1..camadas*mult+1).step(1) do |i|

          if i%2==1
            file.write("G1 Y #{delay.to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")
            file.write("G1 Y #{delay.to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")

            x = (2*Math::PI*r*c/e*i)/l
            file.write("G1 X #{x.to_d.truncate(5).to_f} Y #{(c+delay).to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")
            file.write("G1 X #{x.to_d.truncate(5).to_f} Y #{(c+delay).to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")
            #if i == camadas*mult+1
            #  file.write("G1 X #{x.to_d.truncate(5).to_f} Y #{c+delay.to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")
            #end

          elsif i%2==0
              file.write("G1 Y #{(c - delay).to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")
              file.write("G1 Y #{(c - delay).to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")

              x = (2*Math::PI*r*c/e*i)/l

              file.write("G1 X #{x.to_d.truncate(5).to_f} Y #{(-1*delay).to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")
              file.write("G1 X #{x.to_d.truncate(5).to_f} Y #{(-1*delay).to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")

              #if i == camadas*mult+1
              #  file.write("G1 X #{x.to_d.truncate(5).to_f} Y #{(-1*delay).to_d.truncate(5).to_f} Z #{(r+o).to_d.truncate(5).to_f}\n")
              #end
            end
      end
      velocity = ((30 * 2 * Math::PI * r) / 60).to_i
      seconds =  (x / velocity).to_i
      @winding.estimated_time = Time.at(seconds).utc
      file.close

    end
end
