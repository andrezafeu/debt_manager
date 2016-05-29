class AddDebtIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :debt_id, :integer
  end
end
