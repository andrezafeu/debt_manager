class Debt < ActiveRecord::Base
	validates :name, presence: true
	validates :amount, presence: true
	validates :interest_rate, presence: true
end
