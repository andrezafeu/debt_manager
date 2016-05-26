class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.string :name
      t.float :amount
      t.float :minimum_payment
      t.float :interest_rate
      t.float :interest_amount
      t.date :estimated_payoff_date

      t.timestamps null: false
    end
  end
end
