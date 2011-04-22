require 'test_helper'

class CurrencyTest < Test::Unit::TestCase
  
  test "Currency['HKD'] grabs all the data for HKDs" do
    assert_equal(
    {:code => "HKD", :num => 344, :e => 2, :currency => "Hong Kong dollar", :locations => "Hong Kong Special Administrative Region"},
    Cashish::Currency["HKD"])
  end

  test "Currency[] raises an exception for an imaginary currency" do
    assert_raise(Cashish::MissingCurrencyException) do
      Cashish::Currency["notreal"]
    end
  end
  
end
