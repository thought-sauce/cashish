require 'active_support/memoizable'

module Cashish
  
  module Currency
    
    # http://en.wikipedia.org/wiki/ISO_4217
    #   Code | Num | E | Currency         | Locations using this currency  
    #   HKD  | 344 | 2 | Hong Kong dollar	| Hong Kong Special Administrative Region
    CURRENCIES = YAML.load(File.read(File.dirname(__FILE__)+"/currencies.yml"))
    
    class << self
      
      extend ActiveSupport::Memoizable
      
      def find_by_code(code)
        CURRENCIES[code] || raise(MissingCurrencyException, "no currency #{code}")
      end
      memoize :find_by_code
      
      alias :[] :find_by_code
      
      def codes
        CURRENCIES.keys
      end
    end
    
  end

end