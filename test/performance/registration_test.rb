require 'test_helper'
require 'rails/performance_test_help'

class RegistrationTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test 'registrations' do
    post '/api/v1/registrations', params: {
      user: {
        email: 'alex@kravchenko.com',
        password: 'qwerty',
        password_confirmation: 'qwerty'
      },
      session:
        {
          device_kind: 'web'
        }
    }
  end
end
