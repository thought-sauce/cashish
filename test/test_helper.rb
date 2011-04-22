require 'rubygems'
require 'test/unit'
require 'active_support/testing/declarative'

$: << File.expand_path(File.dirname(__FILE__)+"/../lib")
require 'cashish'

class Test::Unit::TestCase
  extend ActiveSupport::Testing::Declarative
  
  def assert_equal_float(expected, actual, message=nil)
    assert_in_delta expected, actual, 1E-4, message
  end
  
end
