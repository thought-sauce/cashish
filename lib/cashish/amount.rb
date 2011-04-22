require 'active_support/core_ext/array/extract_options'

require 'action_view/helpers/number_helper'

# these are all for the number helper
# today, write this myself and remove these dependencies
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/reverse_merge'
require 'active_support/core_ext/string/output_safety'
require 'i18n'

module Cashish
  class Amount
    include Comparable
    include ActionView::Helpers::NumberHelper

    def initialize(integer_value, currency_code)
      @integer_value = integer_value
      @currency_code = currency_code
      @currency_data = Currency[currency_code]
    end
    attr_reader :integer_value, :currency_code, :currency_data
    
    def inspect
      "#<Cashish::Amount #{self.to_s}>"
    end
    
    def <=>(other)
      if self.currency_code == other.currency_code
        self.integer_value <=> other.integer_value
      end
    end
    
    def +(other)
      if @currency_code == other.currency_code
        Cashish::Amount.new(@integer_value.to_f + other.integer_value.to_f, @currency_code)
      else
        raise "you can't add different currencies"
      end
    end
    
    def -(other)
      if @currency_code == other.currency_code
        Cashish::Amount.new(@integer_value.to_f - other.integer_value.to_f, @currency_code)
      else
        raise "you can't subtract different currencies"
      end
    end
    
    def *(value)
      if value.is_a?(Numeric)
        if @integer_value
          Cashish::Amount.new(@integer_value*value, @currency_code)
        else
          self
        end
      else
        raise "you can only multiply a currency by a numeric"
      end
    end
    
    def /(value)
      if value.is_a?(Numeric)
        if @integer_value
          Cashish::Amount.new(@integer_value/value, @currency_code)
        else
          self
        end
      elsif value.is_a?(Cashish::Amount)
        ratio(value)
      else
        raise "you can only divide a currency by a numeric or another currency"
      end
    end
    
    def decimal_places
      currency_data[:e]
    end

    def decimal_value
      if integer_value
        @decimal_value ||= integer_value * BigDecimal.new("1E-#{decimal_places}")
      end
    end

    # use XE.com's format
    # eg. 14,399.43 USD
    def to_s(*args)
      opts = args.extract_options!
      format = args.first || :full
      
      case format
        when :full   # USD 14,399.43
          "#{formatted_value(opts) || "-"} #{currency_code}"
        when :hide_currency   # 14,399.43
          "#{formatted_value(opts) || "-"}"
        when :simple # 14399.43
          formatted_value(opts.merge(:delimiter => "", :default_to_zero => true))
        else
          raise "bad format"
      end
    end
    
    # the underlying value explicitly as an integer
    def to_i
      self.integer_value.to_i
    end
    
    # the underlying value explicitly as a float
    def to_f
      self.integer_value.to_f
    end

    def formatted_value(opts={})
      this_value = decimal_value
      if opts.delete(:default_to_zero)
        this_value ||= 0
      end

      if this_value
        precision = opts[:precision] || self.decimal_places
        with_precision = "%01.#{precision}f" % this_value
        number_with_delimiter(with_precision, {:separator => '.', :delimiter => ','}.merge(opts))
      end
    end
    
    protected
    
    # the ratio of two currencies
    def ratio(other)
      if @currency_code == other.currency_code
        @integer_value.to_f / other.integer_value.to_f
      else
        raise "you can't find the ratio of two different currencies"
      end
    end

  end
end