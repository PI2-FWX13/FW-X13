json.extract! machine_information, :id, :name, :ip, :created_at, :updated_at
json.url machine_information_url(machine_information, format: :json)
