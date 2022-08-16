module SharedFunctions
    MAX_PAGINATION_LIMIT = 1
    
    def create_response(status_code, msg, data = [], src = nil)
        resp = {}
        resp['status_code'] = status_code
        resp['message'] = msg
        resp['data'] = data unless data.nil?
    
        resp.to_json
    end

    def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,MAX_PAGINATION_LIMIT
        ].min
    end
end