module Api 
  module V1
      class TransactionsController < ApplicationController
      # include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::HttpAuthentication::Token
      before_action :authenticate_user, only: [:create]
      before_action :set_transaction, only: [:show, :update]
      

      # GET /transactions
      def index
        transactions = Transaction.limit(params[:limit])
        # logger.info "All Transactions ===> #{transactions.inspect}"
        render json: TransactionsRepresenter.new(transactions).as_json
      end

      def customer_transaction
        customer_transactions = Transaction.where("customer_id=?",params[:customer_id])
        render json: TransactionsRepresenter.new(customer_transactions).cust_trxn_as_json(params[:customer_id])
      end

      # GET /transactions/1
      def show
        transaction = Transaction.get_single_transaction(@transaction.id)
        logger.info "Transaction ===> #{transaction.inspect}"
        render json: transaction
      end

      # POST /transactions
      def create
        @transaction = Transaction.new(transaction_params)
        @transaction.transaction_id = Transaction.gen_trans_code
        @transaction.trans_status = true
        if @transaction.save
          transaction = Transaction.get_single_transaction(@transaction.id)
          render json: transaction, status: :created
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /transactions/1
      def update
        if @transaction.update(transaction_params)
          transaction = Transaction.get_single_transaction(@transaction.id)
          render json: transaction, status: :created
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      end


      private
       
      def authenticate_user
        # binding.irb
        token, _options = token_and_options(request)
        logger.info "token ===> #{token.inspect}"
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)

      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
     
        # authenticate_with_http_token do |token, options|
        #   # ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
        #   logger.info "token ===> #{token.inspect}"
        #   user_id = AuthenticationTokenService.decode(token)
        #   raise user_id.inspect
        # end
      end

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
