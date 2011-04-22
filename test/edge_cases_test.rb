require 'test_helper'

class EdgeCasesTest < Test::Unit::TestCase
  
  test "3 digits" do
    amount = Cashish::Amount.new(123_456_789, "JOD")
    assert_equal "123,456.789 JOD", amount.to_s
  end
  
  test "0 digits" do
    amount = Cashish::Amount.new(123_456_789, "KRW")
    assert_equal "123,456,789 KRW", amount.to_s
  end
  
  test "0.69897 digits" do
    assert_raise(RuntimeError) do
      Cashish::Amount.new(123_456_789, "MGA")
    end
  end
  
  test "gold" do
    assert_raise(RuntimeError) do
      Cashish::Amount.new(123_456_789, "XAU")
    end
  end
  
end
