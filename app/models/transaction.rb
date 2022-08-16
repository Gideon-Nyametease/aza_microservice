class Transaction < ApplicationRecord
    belongs_to :customer, class_name: "Customer", foreign_key: :customer_id
    attr_accessor :status_trigger
  
    validates_uniqueness_of :transaction_id
    validates :customer_id, presence: true
    validates :input_currency, presence: true
    validates :input_amount, numericality: { greater_than: 0 }
    validates :output_currency, presence: true
    validates :output_amount, numericality: { greater_than: 0 }
  
    def self.get_single_transaction(trans_id)
      transaction_hash = {}
      transaction = Transaction.where("id=?",trans_id).first
      if transaction
        trans_hash = {
            id: transaction.id,
            transaction_id: transaction.transaction_id,
            customer_id: transaction.customer_id,
            input_amount: (transaction.input_amount).to_s,
            input_currency: transaction.input_currency,
            output_amount: (transaction.input_amount).to_s,
            output_currency: transaction.output_currency,
            trans_status: transaction.trans_status,
            active_status: transaction.active_status,
            transaction_date: transaction.created_at
          }
      end
      return trans_hash
    end

    def self.update_trans_status(trigger,trans_id)
      trans_hash = {}
      transaction = Transaction.where("id=?",trans_id).first
      if trigger
        trans_hash = {
          id: transaction.id,
          transaction_id: transaction.transaction_id,
          customer_id: transaction.customer_id,
          input_amount: (transaction.input_amount).to_s,
          input_currency: transaction.input_currency,
          output_amount: (transaction.input_amount).to_s,
          output_currency: transaction.output_currency,
          trans_status: "Paid",
          active_status: transaction.active_status,
          transaction_date: transaction.created_at
        }
      else
        trans_hash = {
          id: transaction.id,
          transaction_id: transaction.transaction_id,
          customer_id: transaction.customer_id,
          input_amount: (transaction.input_amount).to_s,
          input_currency: transaction.input_currency,
          output_amount: (transaction.input_amount).to_s,
          output_currency: transaction.output_currency,
          trans_status: "Failed",
          active_status: transaction.active_status,
          transaction_date: transaction.created_at
        }
      end
      trans_hash
    end

    def self.gen_trans_code
        SecureRandom.uuid
    end
end
