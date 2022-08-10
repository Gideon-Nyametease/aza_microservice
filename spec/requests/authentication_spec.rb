require 'rails_helper'


describe 'Authentication', type: :request do
    describe 'POST /authenticate' do
        it 'authenticates the client' do
            post '/api/v1/authenticate', params: {username: "azaadmin", password:"Password123"}

            expect(response).to have_http_status(:created)
            expect(JSON.parse(response.body)).to eq(
                {
                    'token'=>'123'
                }
            )
        end

        it 'returns error when username is missing' do
            post '/api/v1/authenticate', params: {password:"Password123"}

            expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error when password is missing' do
            post '/api/v1/authenticate', params: {username: "azaadmin"}

            expect(response).to have_http_status(:unprocessable_entity)
        end

    end
end