class MachineSetting < ApplicationRecord
	validates :maximum_offset, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :maximum_size_mandril, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :maximum_size_radius, presence: true, numericality: {greater_than_or_equal_to: 0}
end
