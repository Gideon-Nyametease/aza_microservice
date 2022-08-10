module Api 
  module V1
    class CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :update]

    # GET /customers
    def index
      customers = Customer.all

      render json: customers
    end

    # GET /customers/1
    def show
      customer = Customer.get_single_customer(@customer.id)
      render json: { resp_code: SUCCESS, resp_desc: customer }
    end

    # POST /customers
    def create
      @customer = Customer.new(customer_params)

      if @customer.save
        customer = Customer.get_single_customer(@customer.id)
        render json: {resp_code: SUCCESS, resp_desc: customer }
      else
        render json: {resp_code: FAIL, resp_desc: Utils.errors(@customer)}
      end
    end

    # PATCH/PUT /customers/1
    def update
      if @customer.update(customer_params)
        customer = Customer.get_single_customer(@customer.id)
        render json: {resp_code: SUCCESS, resp_desc: customer }
      else
        render 
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Customer.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def customer_params
        params.require(:customer).permit(:customer_id, :first_name, :last_name, :dob, :phone_number, :active_status)
      end
    end
  end
end