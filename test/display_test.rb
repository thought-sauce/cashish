require 'test_helper'

class DisplayTest < Test::Unit::TestCase

  test "Cashish::Amount" do
    amount = Cashish::Amount.new(12_345_67, "HKD")
    assert_equal "HKD", amount.currency_code
    assert_equal 2, amount.decimal_places
    assert_equal "12,345.67", amount.formatted_value
    assert_equal "12,345.67 HKD", amount.to_s
    assert_equal "12,345.67 HKD", amount.to_s(:full)
    assert_equal "12345.67", amount.to_s(:simple)
    
    assert_equal 12_345_67,   amount.integer_value
    assert_equal 12_345.67,   amount.decimal_value
    assert_equal 12_345_67.0, amount.to_f
    assert_equal 12_345_67,   amount.to_i
  end

  test "Cashish::Amount - negative" do
    amount = Cashish::Amount.new(-12_345_67, "HKD")
    assert_equal "HKD",            amount.currency_code
    assert_equal 2,                amount.decimal_places
    assert_equal "-12,345.67",     amount.formatted_value
    assert_equal "-12,345.67 HKD", amount.to_s
    assert_equal "-12,345.67 HKD", amount.to_s(:full)
    assert_equal "-12345.67",      amount.to_s(:simple)
    
    assert_equal -12_345_67,       amount.integer_value
    assert_equal -12_345.67,       amount.decimal_value
    assert_equal -12_345_67.0,     amount.to_f
    assert_equal -12_345_67,       amount.to_i
  end

  test "Cashish::Amount - nil" do
    amount = Cashish::Amount.new(nil, "HKD")
    assert_equal "HKD",   amount.currency_code
    assert_equal 2,       amount.decimal_places
    assert_equal nil,     amount.formatted_value
    assert_equal "0.00",  amount.formatted_value(:default_to_zero => true)
    assert_equal "- HKD", amount.to_s
    assert_equal "- HKD", amount.to_s(:full)
    assert_equal "0.00",  amount.to_s(:simple)

    assert_equal       nil, amount.integer_value
    assert_equal       nil, amount.decimal_value
    assert_equal_float 0.0, amount.to_f
    assert_equal         0, amount.to_i
  end

  test "Cashish::Amount - float" do
    amount = Cashish::Amount.new(123_456_78.9012, "HKD")
    assert_equal "HKD",            amount.currency_code
    assert_equal 2,                amount.decimal_places
    assert_equal "123,456.79",     amount.formatted_value
    assert_equal "123,456.79 HKD", amount.to_s
    assert_equal "123,456.79 HKD", amount.to_s(:full)
    assert_equal "123456.79",      amount.to_s(:simple)

    assert_equal       123_456_78.9012, amount.integer_value
    assert_equal_float 123_456.789012,  amount.decimal_value
    
    assert_equal_float amount.integer_value,  amount.to_f
    assert_equal       amount.integer_value.to_i, amount.to_i
  end

  test "Cashish::Amount#to_s should accept a precision" do
    amount = Cashish::Amount.new(123_45.678901234, "HKD")
    assert_equal "123.46 HKD",   amount.to_s
    assert_equal "123.4568 HKD", amount.to_s(:precision => 4)
  end

  test "Cashish::Amount#to_s should accept delimiter and separator" do
    amount = Cashish::Amount.new(123_456_789_012_34, "HKD")
    assert_equal "123,456,789,012.34 HKD", amount.to_s
    assert_equal "123o456o789o012-34 HKD", amount.to_s(:delimiter => "o", :separator => "-")
  end

  test "Cashish::Amount#to_s should round to the nearest if given a float" do
    assert_equal "0.02 HKD", Cashish::Amount.new(5/3.0, "HKD").to_s # 0.016666
    assert_equal "0.02 HKD", Cashish::Amount.new(7/3.0, "HKD").to_s # 0.023333
  end

  test "Cashish::Amount#to_s should handle massive numbers" do
    assert_to_s(
    100_000_000_000_000_000_000_00,
    "100,000,000,000,000,000,000.00 HKD")
  end

  test "Cashish::Amount#to_s should keep all significant figures" do
    assert_to_s(123_456_789_012_345_67, "123,456,789,012,345.67 HKD")
  end

  test "ruby patchlevel 173 bug" do
    assert_to_s(100_000_01, "100,000.01 HKD")
  end

  test "simple edge cases" do
    assert_to_s(1_00, "1.00 HKD")
    assert_to_s(   1, "0.01 HKD")
    assert_to_s(  10, "0.10 HKD")
  end

  test "negative numbers" do
    assert_to_s(     -1, "-0.01 HKD")
    assert_to_s(    -12, "-0.12 HKD")
    assert_to_s(   -123, "-1.23 HKD")

    assert_to_s(-123456, "-1,234.56 HKD")
  end
  
  protected

  def assert_to_s(value, expected_to_s)
    assert_equal expected_to_s, Cashish::Amount.new(value,"HKD").to_s, "value of #{value.inspect} came out wrong"
  end

end