class DebtsController < ApplicationController
	before_action :set_debt, only: [ :show, :edit, :destroy, :update]
	# before_action :authenticate_user!, only: [:create, :edit, :destroy, :show]

	def index
    	@my_debts = Debt.all
    	@my_debts_sum = 0
    	@my_interests_sum = 0
    	@my_debts.each do |debt|
      		debt.interest_amount = debt.amount*debt.interest_rate/100
    		@my_debts_sum += debt.amount
    		@my_interests_sum += debt.interest_amount
      	end
  	end
	def new
    	@my_debt = Debt.new
  	end
	def create
		@my_debt = Debt.new(debt_params)
		if @my_debt.save
			@my_debt.interest_amount = @my_debt.amount*@my_debt.interest_rate/100
			respond_to do |format|
				format.html { redirect_to @my_debt, notice: 'Your debt was created!'}
			end
		else
			respond_to do |format|
				format.html { render :new, notice: 'Something went wrong. Please try again!' }
			end
		end
	end
	def show
		@payments = @my_debt.payments
		if @payments.length>0
			@accrued_interest = @my_debt.amount*(@payments.last.date-Date.today)*(@my_debt.interest_rate/100/365.25)*-1
			@payoff_amount = @my_debt.amount + @accrued_interest
		end
	end
	def edit
	end
	def update
	    respond_to do |format|
	      if @my_debt.update(debt_params)
	        format.html { redirect_to @my_debt, notice: 'Your debt was updated!' }
	      else
	        format.html { render :edit }
	      end
	    end
  	end
	def destroy
		if @my_debt.destroy
      		flash[:notice] = "Your debt was deleted!"
      		redirect_to root_path
    	else
      		flash.now[:alert] = "There was an error deleting the debt. Try again."
      	end
	end
	private
	def set_debt
      	@my_debt = Debt.find(params[:id])
    end
	def debt_params
      	params.require(:debt).permit(:name, :amount, :minimum_payment, :interest_rate, 
      		:interest_amount, :estimated_payoff_date)
    end
end