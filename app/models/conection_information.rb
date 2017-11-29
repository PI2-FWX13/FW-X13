class ConectionInformation < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :ip_cable, presence: true, uniqueness: true
end
