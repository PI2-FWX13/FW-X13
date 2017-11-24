module ConectionInformationsHelper
	def current_connection(connection)
		$current_connection = ConectionInformation.find(connection.id)
	end
end
