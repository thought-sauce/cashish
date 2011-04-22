require 'test_helper'

class ArithmeticTest < Test::Unit::TestCase
  
  test "addition" do
    sum = Cashish::Amount.new(12_34, "HKD") + Cashish::Amount.new(500_00, "HKD")
    assert_instance_of Cashish::Amount, sum
    assert_equal "512.34 HKD", sum.to_s
  end

  test "addition to nil" do
    sum = Cashish::Amount.new(nil, "HKD") + Cashish::Amount.new(500_00, "HKD")
    assert_instance_of Cashish::Amount, sum
    assert_equal "500.00 HKD", sum.to_s
  end

  test "addition of nil" do
    sum = Cashish::Amount.new(12_34, "HKD") + Cashish::Amount.new(nil, "HKD")
    assert_instance_of Cashish::Amount, sum
    assert_equal "12.34 HKD", sum.to_s
  end

  test "subtraction" do
    sum = Cashish::Amount.new(123_45, "HKD") - Cashish::Amount.new(21_00, "HKD")
    assert_instance_of Cashish::Amount, sum
    assert_equal "102.45 HKD", sum.to_s
  end

  test "subtraction from nil" do
    sum = Cashish::Amount.new(nil, "HKD") - Cashish::Amount.new(21_00, "HKD")
    assert_instance_of Cashish::Amount, sum
    assert_equal "-21.00 HKD", sum.to_s
  end

  test "subtraction of nil" do
    sum = Cashish::Amount.new(123_45, "HKD") - Cashish::Amount.new(nil, "HKD")
    assert_instance_of Cashish::Amount, sum
    assert_equal "123.45 HKD", sum.to_s
  end

  test "multiplication" do
    sum = Cashish::Amount.new(12_34, "HKD") *4
    assert_instance_of Cashish::Amount, sum
    assert_equal "49.36 HKD", sum.to_s
  end

  test "multiplication of nil" do
    it = Cashish::Amount.new(nil, "HKD")
    sum = it * 4
    assert_equal "- HKD", sum.to_s
  end

  test "division" do
    sum = Cashish::Amount.new(12_34, "HKD") / 2
    assert_instance_of Cashish::Amount, sum
    assert_equal "6.17 HKD", sum.to_s
  end

  test "division of nil" do
    it = Cashish::Amount.new(nil, "HKD")
    sum = it / 4
    assert_equal "- HKD", sum.to_s
  end

  test "division of two currencies" do
    sum = Cashish::Amount.new(123_45, "HKD") / Cashish::Amount.new(21_00, "HKD")
    assert_instance_of Float, sum
    assert_equal_float 123_45.0 / 21_00.0, sum
  end
end
