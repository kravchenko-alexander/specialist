module V1::Exceptions::Handler
  extend ActiveSupport::Concern

  included do
    rescue_from :all do |exception|
      case exception
      when ActiveRecord::RecordNotFound
        render_error!('RecordNotFound', exception.message, 404)
      when ActiveRecord::RecordInvalid
        render_error!('ValidationErrors', exception.message, 422)
      when Grape::Exceptions::ValidationErrors
        render_error!('ValidationErrors', exception.message, 422)
      else
        Rails.logger.error "\n#{exception.class.name} (#{exception.message}):"
        exception.backtrace.each { |line| Rails.logger.error line }

        render_error!('BadRequest', 'Bad Request. See server logs for more info', 400)
      end
    end

    helpers do
      def render_error!(type, message, code)
        error!({ message: message, type: type, with: V1::Entities::Errors::CommonError }, code)
      end
    end
  end
end
