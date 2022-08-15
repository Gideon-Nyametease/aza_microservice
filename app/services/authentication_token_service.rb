class AuthenticationTokenService
    HMAC_SECRET = Rails.application.credentials.jwt[:hmac_secret]
    ALGO_TYPE = Rails.application.credentials.jwt[:algo_type]

    def self.encode(user_id)
        # p "id from auth service ==> #{user_id}"
        payload = {"user_id"=> user_id}
        JWT.encode payload, HMAC_SECRET, ALGO_TYPE
    end

    def self.decode(token)
        decoded_token = JWT.decode token, HMAC_SECRET, true, { algorithm:ALGO_TYPE }
        decoded_token[0]["user_id"]
    end
end