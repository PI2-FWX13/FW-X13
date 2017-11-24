class Mandril < ApplicationRecord
	validates :compriment, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :radius, presence: true, numericality: {greater_than_or_equal_to: 0}
end
