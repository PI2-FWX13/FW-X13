module Validation

	def validate_winding_mandril(winding)
		mandril = Mandril.first
		val_fail = false
		flash[:error] = [""]
		if winding.length > mandril.compriment
			flash[:error] << 'Length bigger than mandril compriment'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		end
		if winding.radius > mandril.radius
			flash[:error] << 'Radiius bigger than mandril radius'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		end

		val_fail
	end

	def validate_needed_wire(winding)
		flash[:error] = [""]
		val_fail = false
		needed_wire = 360 * winding.length * (winding.layers + 1) / winding.filament_width
		if needed_wire > winding.filament_length
			flash[:error] << 'Filament length is not enough'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		end
		val_fail
	end

	def validate_winding(winding)
		if(validate_winding_mandril(winding) || validate_needed_wire(winding) || validate_winding_offset(winding))
			return false
		end
		return true
	end

	def verify_have_machine_setting
		set_machine_setting
		return unless @machine_setting.nil?
		flash[:notice] = ["Please configure the machine"]
		redirect_to conection_information_connect_path($current_connection) 
	end

	def validate_winding_offset(winding)
		set_machine_setting
		flash[:error] = [""]
		val_fail = false
		if winding.offset > @machine_setting.maximum_offset
			flash[:error] << 'Offset bigger than allowed'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		end
		val_fail
	end

	def validate_mandril(mandril)
		set_machine_setting
		flash[:error] = [""]
		val_fail = false
		if mandril.compriment > @machine_setting.maximum_size_mandril
			flash[:error] << "Mandril comprimet bigger than machine allow"
			redirect_to mandril_edit_path(mandril.id)
			return !val_fail
		end
		if mandril.radius > @machine_setting.maximum_size_radius
			flash[:error] << "Mandril radius bigger than machine allow"
			redirect_to mandril_edit_path(mandril.id)
			return !val_fail
		end
		val_fail
	end

	private
	def set_machine_setting
		@machine_setting = MachineSetting.find_by(conection_information_id: $current_connection.id)
	end
end