ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'user_test_helper'

class ActiveSupport::TestCase
  ActiveRecord::FixtureSet.context_class.send :include, UserTestHelper

  fixtures :all

end
