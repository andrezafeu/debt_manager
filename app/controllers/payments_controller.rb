class PaymentsController < ApplicationController
	before_action :set_debt, only: [ :new, :show]
	def new
		@my_payment = Payment.new
  	end
	def create
		@my_payment = Payment.new(payment_params)
		@my_debt = Debt.find(params[:debt_id])
		@my_payment.debt_id = @my_debt.id
		if @my_payment.save
			respond_to do |format|
				format.html { redirect_to @my_debt, notice: 'Your payment was registered'}
			end
		else
			respond_to do |format|
				format.html { render :new, notice: 'Something went wrong. Please try again!' }
			end
		end
	end
	private
	def set_debt
		@my_debt = Debt.find(params[:debt_id])
	end
	def payment_params
      	params.require(:payment).permit(:value, :date)
    end
end
