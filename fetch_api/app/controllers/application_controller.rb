class ApplicationController < ActionController::API
    def require_params(*symbols)
        missing_params = symbols.select { |sym| !params[sym].present? }
        if missing_params.empty?
          return
        else
          error_message = missing_params.join(', ') + (missing_params.length > 1 ? ' parameters are' : ' parameter is') + ' required'
          raise ActionController::ParameterMissing.new(error_message)
        end
      end
        
end
