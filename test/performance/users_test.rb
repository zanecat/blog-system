require 'test_helper'
require 'rails/performance_test_help'

class UsersTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 999, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test "index" do
    get '/users'
  end

  test "new" do
  	get '/users/new'
  end

  test 'show' do
  	get '/users/1'
  end

  test 'update' do
  	patch '/users/1'
  end

  test 'edit' do
  	get '/users/1/edit'
  end
end
