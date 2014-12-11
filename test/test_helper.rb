ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'user_test_helper'

Capybara.app = Pienkowski::Application

class ActiveSupport::TestCase
  ActiveRecord::FixtureSet.context_class.send :include, UserTestHelper
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
