class Winding < ApplicationRecord
	validates :project_name, presence: true, uniqueness: true
	validates :length, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :radius, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :offset, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :filament_width, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :filament_length, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :gelPot, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :density, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
    validates :layers, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :angle, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 180}
    validates :winding_date, presence: true
    validates :winding_type, presence: true

	def self.search(search)
	  where("projectName LIKE ?", "%#{search}%") 
	end
end
