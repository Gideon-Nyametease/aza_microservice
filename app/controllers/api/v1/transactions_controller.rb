module Api 
  module V1
      class TransactionsController < ApplicationController
      before_action :set_transaction, only: [:show, :update, :destroy]

      # GET /transactions
      def index
        @transactions = Transaction.all
        logger.info "All Transactions ===> #{t@ransactions.inspect}"
        render json: @transactions
      end

      # GET /transactions/1
      def show
        transaction = Transaction.get_single_transaction(@transaction.id)
        logger.info "Transaction ===> #{transaction.inspect}"
        render json: { resp_code: SUCCESS, resp_desc: transaction }
      end

      # POST /transactions
      def create
        @transaction = Transaction.new(transaction_params)
        @transaction.transaction_id = Transaction.gen_trans_code
        @transaction.trans_status = true
        if @transaction.save
          transaction = Transaction.get_single_transaction(@transaction.id)
          render json: {resp_code: SUCCESS, resp_desc: transaction }
        else
          render json: {resp_code: FAIL, resp_desc: Utils.errors(@transaction)}
        end
      end

      # PATCH/PUT /transactions/1
      def update
        if @transaction.update(transaction_params)
          transaction = Transaction.get_single_transaction(@transaction.id)
          render json: {resp_code: SUCCESS, resp_desc: transaction }
        else
          render json: { resp_code: FAIL, resp_desc: Utils.errors(@transaction) }
        end
      end


      private
        # Use callbacks to share common setup or constraints between actions.
        def set_transaction
          @transaction = Transaction.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def transaction_params
          params.require(:transaction).permit(:transaction_id, :customer_id, :input_currency, :input_amount, :output_currency, :output_amount, :trans_status, :active_status)
        end
    end
  end
end
