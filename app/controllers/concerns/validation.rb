module Validation

	def validate_winding_mandril(winding)
		mandril = Mandril.first
		val_fail = false
		if winding.length > mandril.compriment
			flash[:error] = 'Comprimento maior que o permitido'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		elsif winding.radius > mandril.radius
			flash[:error] = 'Raio maior que o permitido'
			redirect_to new_winding_path(winding.winding_type)
			return !val_fail
		end

		val_fail
	end

end