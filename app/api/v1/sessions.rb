class V1::Sessions < Grape::API
  resources :sessions do
    desc 'User login, create session' do
      success V1::Entities::User
      failure [[401, 'LoginError', V1::Entities::Errors::CommonError]]
    end
    params do
      requires :user, type: Hash do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end
      requires :session, type: Hash do
        requires :device_kind, type: String, desc: 'Device kind', values: Session.device_kinds.keys
        optional :push_token, type: String, desc: 'Push token'
      end
    end
    post do
      user = User.find_by!(email: declared(params).user.email)
      raise Exceptions::LoginError unless user.authenticate(declared(params).user.password)
      provider = Providers::Email.find_or_create_by!(user: user)
      session = user.sessions.create!(declared(params).session.merge(provider_id: provider.id))
      make_headers_for session
      present user, with: V1::Entities::User
    end

    desc 'Update session (push-token)' do
      success V1::Entities::SuccessMessages::Message
      failure [[401, 'AuthorizedError', V1::Entities::Errors::CommonError],
               [401, 'InvalidGrandType', V1::Entities::Errors::CommonError]]
      headers Headers::REQUIRED_HEADERS
    end
    params do
      requires :session, type: Hash do
        requires :push_token, type: String, desc: 'Push token'
      end
    end
    put do
      authenticate!
      current_session.update!(declared(params).session)
      present status, with: V1::Entities::SuccessMessages::Message
    end

    desc 'User logout, delete session' do
      success V1::Entities::SuccessMessages::Message
      failure [[401, 'InvalidGrandType', V1::Entities::Errors::CommonError],
              [401, 'AuthorizedError', V1::Entities::Errors::CommonError]]
      headers Headers::REQUIRED_HEADERS
    end
    delete do
      authenticate!
      logout!
      present status, with: V1::Entities::SuccessMessages::Message
    end

    resource :refresh_token do
      desc 'Update session (new refresh-token)' do
        success V1::Entities::SuccessMessages::Message
        failure [[401, 'AuthorizedError', V1::Entities::Errors::CommonError],
                 [401, 'InvalidGrandType', V1::Entities::Errors::CommonError]]
        headers Headers::REQUIRED_HEADERS
      end
      put do
        raise Exceptions::InvalidGrandType unless headers['Grand-Type'] == 'refresh-token'
        session = Session.refresh_active.find_by(refresh_token: headers['Refresh-Token'])
        raise Exceptions::AuthorizedError unless session || session.user == current_user
        session.refresh!
        make_headers_for session
        present status, with: V1::Entities::SuccessMessages::Message
      end
    end
  end
end
