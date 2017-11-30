class ConectionInformation < ApplicationRecord
	has_one :machine_settings

	validates :name, presence: true, uniqueness: true
	validates :ip, presence: true, uniqueness: true
	validates :wifi_name, presence: false, uniqueness: false
	validates :password, presence: false, uniqueness: false
end
