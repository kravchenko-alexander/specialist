class V1::Test < Grape::API
  resources :tests do
    before do
    end

    desc 'Test endpoint' do
      success V1::Entities::SuccessMessages::Message
    end
    params do
    end
    post do
      present status, with: V1::Entities::SuccessMessages::Message
    end
  end
end
