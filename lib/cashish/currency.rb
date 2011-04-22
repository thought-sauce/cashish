require 'active_support/memoizable'

module Cashish
  
  module Currency
    
    # http://en.wikipedia.org/wiki/ISO_4217
    #   Code | Num | E | Currency         | Locations using this currency  
    #   HKD  | 344 | 2 | Hong Kong dollar	| Hong Kong Special Administrative Region
    CURRENCIES = [
      {:code => "HKD", :num => 344, :e => 2, :currency => "Hong Kong dollar", :locations => "Hong Kong Special Administrative Region"},
      {:code => "SGD", :num => 702, :e => 2, :currency => "Singapore dollar", :locations => "Singapore"}
    ]
    
    class << self
      
      extend ActiveSupport::Memoizable
      
      def find_by_code(code)
        CURRENCIES.detect{|currency| currency[:code] == code} || raise(MissingCurrencyException, "no currency #{code}")
      end
      memoize :find_by_code
      
      alias :[] :find_by_code
      
      def codes
        CURRENCIES.map{|currency| currency[:code]}
      end
    end
    
  end

end