class ApplicationController < ActionController::API
    respond_to :json
    wrap_parameters format: [:json]

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from ActionController::RoutingError, with: :invalid_route


    def invalid_route
        render json: create_response(404, 'Invalid path', nil), status: :not_found
    end

    private

    def record_not_found
        render json: create_response(404, 'Record not found', nil), status: :not_found
    end

    def bad_request
        render json: create_response(400, 'Bad Request. POST requests need body', nil), status: :bad_request
    end

end
