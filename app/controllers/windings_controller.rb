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
    generate_gcode

    respond_to do |format|
      #validation for wire length
      needed_wire = 360*@winding.length*(@winding.layers+1)/@winding.filamentWidth
      #print "WIRE NEEDED " + needed_wire

      if @winding.filamentLength > needed_wire
        if @winding.save
          format.html { redirect_to @winding, notice: 'Winding was successfully created.' }
          format.json { render :show, status: :created, location: @winding }
        else
          format.html { render :new }
          format.json { render json: @winding.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }

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
