class TransactionsRepresenter
    def initialize(transactions)
        @transactions = transactions
    end

    def as_json
        transactions.map do |transaction|
          {
              id: transaction.id,
              transaction_id: transaction.transaction_id,
              customer_id: transaction.customer_id,
              input_amount: transaction.input_amount,
              input_currency: transaction.input_currency,
              output_amount: transaction.output_amount,
              output_currency: transaction.output_currency,
              trans_status: transaction.trans_status,
              active_status: transaction.active_status
          }
        end
    end

    def cust_trxn_as_json(*customer_id)
        transactions = Transaction.where(customer_id: customer_id[0]) 
        cust_transaction = transactions.map do |transaction|
         {
              id: transaction.id,
              transaction_id: transaction.transaction_id,
              customer_id: transaction.customer_id,
              input_amount: transaction.input_amount,
              input_currency: transaction.input_currency,
              output_amount: transaction.output_amount,
              output_currency: transaction.output_currency,
              trans_status: transaction.trans_status,
              active_status: transaction.active_status
          }
        end
        cust_transaction
    end



    private

    attr_reader :transactions
end
