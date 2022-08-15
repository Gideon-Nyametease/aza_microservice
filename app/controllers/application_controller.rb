class ApplicationController < ActionController::API
    before_action :set_default_format
   

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :missing_param
    rescue_from ActionController::RoutingError, with: :invalid_route
    
    def create_response(status_code, msg, data = [], src = nil)
        resp = {}
        resp['status_code'] = status_code
        resp['message'] = msg
        resp['data'] = data unless data.nil?
    
        resp.to_json
    end

    # def invalid_route
    #     render json: create_response(404, 'Invalid path', nil), status: :not_found
    # end

    private

    # def record_not_found
    #     render json: create_response(404, 'Record not found', nil), status: :not_found
    # end

    def missing_param(e)
        render json: create_response(422,{error: e.message},nil), status: :unprocessable_entity
    end

    def set_default_format
        request.format = :json
    end
end
