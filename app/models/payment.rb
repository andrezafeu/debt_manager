class Payment < ActiveRecord::Base
	validates :value, presence: true
	# validates :date, presence: true

	belongs_to :debt
end
