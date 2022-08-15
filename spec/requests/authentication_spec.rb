require 'rails_helper'


describe 'Authentication', type: :request do
    describe 'POST /authenticate' do
        let(:user) {FactoryBot.create(:user, username:"Admin1", password:"Password123")}
        
        it 'authenticates the client' do
            post '/api/v1/authenticate', params: {username: user.username, password:"Password123"}

            expect(response).to have_http_status(:created)
            expect(JSON.parse(response.body)).to eq(
                {
                    'token'=>'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w'
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

        it 'returns error when password is wrong' do
            post '/api/v1/authenticate', params: { username: user.username, password:"incorrect"}

            expect(response).to have_http_status(:unauthorized)
        end

    end
end