module V1::Helpers::SessionsHelper
  extend Grape::API::Helpers

  def current_user
    @current_user ||= User.find_by(id: headers['Client-Id'], secret_token: headers['Client-Secret'])
  end

  def current_session
    @current_session ||= Session.active.find_by(access_token: headers['Access-Token'])
  end

  def authenticate!
    raise Exceptions::InvalidGrandType unless headers['Grand-Type'] == 'bearer'
    return true if current_session && current_session.user == current_user
    raise Exceptions::AuthorizedError
  end

  def logout!
    current_session.destroy!
  end

  def make_headers_for(session)
    user = session.user
    header('Client-Id', user.id)
    header('Client-Secret', user.secret_token)
    header('Access-Token', session.access_token)
    header('Access-Token-Expiration', session.access_token_expiration.to_i)
    header('Refresh-Token', session.refresh_token)
    header('Refresh-Token-Expiration', session.refresh_token_expiration.to_i)
  end
end
