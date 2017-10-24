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
    if Mandril.count == 0
      @mandril = Mandril.new(compriment: 0, radius: 0, mandril_type: params[:type])
    else
      @mandril = Mandril.first
    end
    @winding = Winding.new(winding_type: params[:type])
  end
  # POST /windings
  # POST /windings.json
  def create
    @winding = Winding.new(winding_params)
    generate_gcode

    #validation for wire length
    needed_wire = 360*@winding.length*(@winding.layers+1)/@winding.filamentWidth
    #print "WIRE NEEDED " + needed_wire


  #  if @winding.filamentLength > needed_wire
      if @winding.save
        session[:id] = @winding.id
        redirect_to action: "graph"
  #      redirect_to :action => "monitor"
  #    else
        #deal with errors
      end
  #  else
      #deal with errors
  #  end
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

  def graph
    id = session[:id]
    if id == nil
      redirect_to action: "new", type: "Cylinder"
    else
      @winding = Winding.find(id)
      session[:id] = nil
    end
  end

  def monitor
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
