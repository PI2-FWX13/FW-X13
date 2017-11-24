module Validation

	def validate_winding_mandril(winding)
		mandril = Mandril.first
		val_fail = false
		if winding.length > mandril.compriment
			flash[:error] = 'Length bigger than mandril compriment'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		elsif winding.radius > mandril.radius
			flash[:error] = 'Radiius bigger than mandril radius'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		end

		val_fail
	end

	def validate_needed_wire(winding)
		val_fail = false
		needed_wire = 360 * winding.length * (winding.layers + 1) / winding.filament_width
		if needed_wire > winding.filament_length
			flash[:error] = 'Filament length is not enough'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		end

		val_fail
	end

	def validate_winding(winding)
		if(validate_winding_mandril(winding) || validate_needed_wire(winding))
			return false
		end
		return true
	end

end