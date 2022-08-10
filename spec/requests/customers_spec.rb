# require 'rails_helper'

# describe 'Customer', type: :request do
#     describe "GET /index" do
#         before do
#           FactoryBot.create_list(:customer, 2)
#           get '/api/v1/customers'
#         end
    
#         it 'returns all customers' do
#           expect(json["rows"].size).to eq(2)
#         end
    
#         it 'returns status code 200' do
#           expect(response).to have_http_status(:success)
#         end
#       end
    
    
#       describe "GET /show" do
#         let!(:customer) { FactoryBot.create(:customer) }
#         let!(:cust_id) { customer.id }
#         before do
#           get "/api/v1/customer/#{customer.id}"
#         end
    
#         it 'returns the specific customer id' do
#           expect(json["resp_desc"]["customer_id"]).to eq(cust_id)
#         end
    
#         it 'returns response code 000' do
#           expect(json["resp_code"]).to eq(success)
#         end
    
#       end
    
    
    
    
#       describe "GET /create" do
#         context "with valid parameters" do
#           let(:valid_params) do
#             { customer: {
#                 first_name: Faker::Name.name,
#                 last_name: Faker::Name.name,
#                 other_names: Faker::Name.name,
#                 date_of_birth: Faker::Date.between(from: '1900-09-23', to: '2009-09-25'),
#                 phone_number: Faker::PhoneNumber.cell_phone_in_e164,
#                 location: Faker::Address.city,
#                 height: Faker::Number.decimal(l_digits: 2),
#                 is_active: true # { Faker::Boolean.boolean }
#             }}
#           end
    
#           it "creates a new customer" do
#             expect { post "/api/v1/customers", params: valid_params}.to change(Customer, :count).by(1)
#             expect(response).to have_http_status(200)  # it's use for code 200
#           end
    
#           it "creates a customer with the correct attributes" do
#             post "/api/v1/customers", params: valid_params
#             expect(Customer.order(id: :desc).first).to have_attributes valid_params[:customer]
#             expect(json["resp_code"]).to eq(success)
#           end
#         end
    
#         context "with invalid parameters" do
#           # testing for validation failures is just as important!
#           let(:valid_params) do
#             { customer: {
#                 first_name: Faker::Name.name,
#                 last_name: Faker::Name.name,
#                 date_of_birth: Faker::Date.between(from: '1900-09-23', to: '2009-09-25'),
#                 phone_number: '',
#                 location: Faker::Address.city,
#                 status: true # { Faker::Boolean.boolean }
#             }}
#           end
    
#           it "cannot create a new customer due to validation error" do
#             expect { post "/api/v1/customers", params: valid_params}.to change(Customer, :count).by(0)
#             expect(response).to have_http_status(200)  # it's use for code 200
#           end
    
#           it "cannot create a customer with the wrong attributes" do
#             post "/api/v1/customers", params: valid_params
#             expect(json["resp_code"]).to eq(fail)
#           end
    
#         end
#       end
# end