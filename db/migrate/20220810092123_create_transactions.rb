class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.string :customer_id
      t.string :input_currency
      t.decimal :input_amount
      t.string :output_currency
      t.decimal :output_amount
      t.string :trans_status
      t.boolean :active_status

      t.timestamps
    end
  end
end
