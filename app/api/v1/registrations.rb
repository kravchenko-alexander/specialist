class V1::Registrations < Grape::API
  resources :registrations do
    desc 'User registration' do
      success V1::Entities::User
      failure [[422, 'ValidationError', V1::Entities::Errors::CommonError]]
    end
    params do
      requires :user, type: Hash do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
        requires :password_confirmation, type: String, desc: 'User password confirmation'
        optional :first_name, type: String, desc: 'User first name'
        optional :last_name, type: String, desc: 'User last name'
        optional :birthday, type: Date, desc: 'Date of birth'
        optional :gender, type: String, desc: 'User gender', values: User.genders.keys
      end
      requires :session, type: Hash do
        requires :device_kind, type: String, desc: 'Device kind', values: Session.device_kinds.keys
        optional :push_token, type: String, desc: 'Push token'
      end
    end
    post do
      user = User.create!(declared(params).user)
      provider = Providers::Email.create!(user: user)
      session = user.sessions.create!(declared(params).session.merge(provider_id: provider.id))
      make_headers_for session
      present user, with: V1::Entities::User
    end
  end
end
