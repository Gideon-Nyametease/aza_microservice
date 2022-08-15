module SharedFunctions
    def create_response(status_code, msg, data = [], src = nil)
        resp = {}
        resp['status_code'] = status_code
        resp['message'] = msg
        resp['data'] = data unless data.nil?
    
        resp.to_json
    end
end