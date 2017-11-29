json.extract! conection_information, :id, :name, :wifi_name, :password, :ip, :created_at, :updated_at
json.url conection_information_url(conection_information, format: :json)
