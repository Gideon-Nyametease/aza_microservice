class ModifyTransactionColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :transactions, :transaction_id, null: false
    change_column_null :transactions, :customer_id, null: false
    change_column_null :transactions, :input_currency, null: false
    change_column_null :transactions, :output_currency, null: false
    change_column_null :transactions, :input_amount, precision: 10, scale: 2, null: false
    change_column_null :transactions, :output_amount, precision: 10, scale: 2, null: false
    change_column :transactions, :trans_status, :string, default: "Pending"
    change_column :transactions, :active_status, :boolean, default: false
  end
end
