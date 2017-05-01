class V1::Entities::Errors::CommonError < Grape::Entity
  expose :message, documentation: { type: String, desc: 'Error message' }
  expose :type, documentation: { type: String, desc: 'Error type' }
end
