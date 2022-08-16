class ApplicationController < ActionController::API
    class AuthenticationError < StandardError; end

    require 'shared_functions'

    before_action :set_default_format

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :missing_param
    rescue_from ActionController::RoutingError, with: :invalid_route
    rescue_from AuthenticationError, with: :unauthenticated
    
   

   

    private

    # def record_not_found
    #     render json: create_response(404, 'Record not found', nil), status: :not_found
    # end

    # def invalid_route
    #     render json: create_response(404, 'Invalid path', nil), status: :not_found
    # end
    def unauthenticated
        head :unauthorized
    end

    def missing_param(e)
        render json: create_response(422,{error: e.message},nil), status: :unprocessable_entity
    end

    def set_default_format
        request.format = :json
    end
end
