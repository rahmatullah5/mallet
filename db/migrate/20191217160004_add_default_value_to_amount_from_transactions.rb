class AddDefaultValueToAmountFromTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :amount, :float, :default => 0
  end
end
