class DebtsController < ApplicationController
	before_action :set_debt, only: [ :show, :edit, :destroy, :update]
	# before_action :authenticate_user!, only: [:create, :edit, :destroy, :show]

	def index
    	@my_debts = Debt.all
    	@my_debts_sum = 0;
    	@my_debts.each do |debt|
    		debt.payments.each do |payment|
      			debt.amount -= payment.value
      		end
    		@my_debts_sum += debt.amount
      	end
      	@my_debts_sum
  	end
	def new
    	@my_debt = Debt.new
  	end
	def create
		@my_debt = Debt.new(debt_params)
		if @my_debt.save
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
      	@my_debt.payments.each do |payment|
      		@my_debt.amount -= payment.value
      	end
    end
	def debt_params
      	params.require(:debt).permit(:name, :amount, :minimum_payment, :interest_rate, 
      		:interest_amount, :estimated_payoff_date)
    end
end
