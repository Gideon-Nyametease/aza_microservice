require 'rails_helper'


describe 'Transactions', type: :request do

    describe 'GET /index' do
        let!(:customer) { FactoryBot.create(:customer, active_status: true) }
        before do
            2.times do
                FactoryBot.create(:transaction, customer_id: customer.id)
            end
        end

        it 'returns all transactions' do
            get '/api/v1/transactions'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end

        it 'returns a subset of trasanctions based on pagination limit' do
            get '/api/v1/transactions', params: {limit:1}

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(1)
        end

      
    end

    describe 'POST /transactions' do
        context "valid parameters" do
            let!(:customer) { FactoryBot.create(:customer, active_status: true) }
            let(:valid_params) do
              { transaction: {
                  customer_id: customer.id,
                  transaction_id: Transaction.gen_trans_code,
                  input_amount: Faker::Number.decimal(l_digits: 2),
                  input_currency: Faker::Currency.code,
                  output_amount: Faker::Number.decimal(l_digits: 2),
                  output_currency: Faker::Currency.code,
                  active_status: true,
                  trans_status: "PASSED"
              }}
            end
      
            it "creates a new transaction" do
              expect { post "/api/v1/transactions", params: valid_params}.to change(Transaction, :count).by(1)
              expect(response).to have_http_status(:created) 
            end
      
            it "creates a transaction with the correct attributes" do
              post "/api/v1/transactions", params: valid_params
              expect(JSON.parse(response.code)).to eq(201)
            end
        end

        context "invalid parameters" do
            let(:valid_params) do
              { transaction: {
                  input_amount: "#{Faker::Number.decimal(l_digits: 2)}",
                  input_currency: Faker::Currency.code,
                  output_amount: "#{Faker::Number.decimal(l_digits: 2)}",
                  output_currency: Faker::Currency.code,
                  active_status: true,
                  trans_status: "Failed"
              }}
            end
      
            it "can't create new transaction because validation failed" do
              expect { post "/api/v1/transactions", params: valid_params}.to change(Transaction, :count).by(0)
              expect(response).to have_http_status(422)
            end
      
            it "can't create new transaction with wrong attributes" do
              post "/api/v1/transactions", params: valid_params
              expect(JSON.parse(response.code)).to eq(422)
            end
      
        end
    end

    describe 'GET /transaction' do
        let!(:customer) { FactoryBot.create(:customer, active_status: true) }
        let!(:transaction) { FactoryBot.create(:transaction, customer_id: customer.id) }
        let!(:transaction_id) { transaction.id }
        before do
            get "/api/v1/transactions/#{transaction.id}"
        end

        it 'returns the specific transaction id' do
            expect(JSON.parse(response.body)['id']).to eq(transaction_id)
        end
    end
end

describe 'Transactions Api v1 Routes', type: :routing do
    describe "transaction routes" do
        it "routes to #index" do
          expect(get: "api/v1/transactions").to route_to("api/v1/transactions#index")
        end

        it "routes to #create" do
          expect(post: "api/v1/transactions").to route_to("api/v1/transactions#create")
        end
    
        it "routes to #show" do
          expect(get: "api/v1/transactions/1").to route_to("api/v1/transactions#show", id: "1")
        end
    end
end