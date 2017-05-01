class V1::Entities::SuccessMessages::Message < Grape::Entity
  expose :success, documentation: { type: 'string', values: [true] }

  private

  def success
    true
  end
end
