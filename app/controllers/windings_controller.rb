class WindingsController < ApplicationController
  before_action :set_winding, only: [:show, :edit, :update, :destroy]

  require 'net/scp'
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
    @winding = Winding.new
  end
  # POST /windings
  # POST /windings.json
  def create
    @winding = Winding.new(winding_params)
    generate_gcode

    #validation for wire length
    needed_wire = 360*@winding.length*(@winding.layers+1)/@winding.filamentWidth
    #print "WIRE NEEDED " + needed_wire


    if @winding.filamentLength > needed_wire
      @winding.windingdate = DateTime.now.to_date
      if @winding.save
        sendgcode
        redirect_to :action => "monitor"
      else
        #deal with errors
      end
    else
      #deal with errors
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

  def choose
  end

  @@current_temperature = 0

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
    host = '192.168.25.12'
    #192.168.25.11
    login = 'pi'
    password = 'raspberry'

    Net::SSH.start(host, login, :password => password) do |ssh|
      #while(@@current_temperature != 'END')
        output = ssh.exec!"tail -1 /home/pi/temperature.out"
        @@current_temperature = output

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

      begin
        host = '192.168.25.12'
        #192.168.25.11
        login = 'pi'
        password = 'raspberry'

        Net::SCP.start(host, login, :password => password) do |scp|
          puts 'SCP Started!'
          scp.upload('gcode', '/home/pi/')
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_winding
      @winding = Winding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def winding_params
      params.require(:winding).permit(:projectName, :length, :radius, :offset, :filamentWidth, :filamentLength, :gelPot, :density, :layers, :angle, :windingdate)
    end

    def generate_gcode

      camadas = @winding.layers
      a = @winding.angle
      c = @winding.length
      e = @winding.filamentWidth
      o = @winding.offset
      r = @winding.radius
      x = 0

      file = File.open("gcode","w")

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
            file.write("G1 Y #{delay} Z #{r+o}\n")
            x = (360*c/e*i)/l
            file.write("G1 X #{x} Y #{c+delay} Z #{r+o}\n")

          elsif i%2==0
              file.write("G1 Y #{c - delay} Z #{r+o}\n")
              x = (360*c/e*i)/l
              file.write("G1 X #{x} Y #{-1*delay} Z #{r+o}\n")
            end
      end
      file.close
    end
end
