class ConectionInformation < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :ip, presence: true, uniqueness: true
end
