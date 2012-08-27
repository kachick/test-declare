require 'test/unit'
require_relative 'exceptions'
require_relative 'assertions'

module Test

  module Declare
  
    @declare_class_counter = 0

    class << self
      
      COUNTER_FORMAT_LENGTH = 4
      COUNTER_FORMAT_BASE_NUMBER = 36
      COUNTER_INT_MAX = ('Z' * COUNTER_FORMAT_LENGTH).to_i COUNTER_FORMAT_BASE_NUMBER
      
      if respond_to? :private_constant
        private_constant :COUNTER_FORMAT_LENGTH, :COUNTER_FORMAT_BASE_NUMBER, :COUNTER_INT_MAX
      end
      
      attr_accessor :declare_class_counter

      # @return [Test::Unit::TestCase]
      def new_test_case(target, &block)
        eigen = self
        eigen.declare_class_counter += 1
        
        Class.new ::Test::Unit::TestCase do |cls|
          sort_id = eigen.format_sequence eigen.declare_class_counter
          ::Object.const_set :"Test_TestDeclare_#{sort_id}", cls

          @declare_method_counter = 0
          
          extend Assertions
          
          singleton_class.class_eval do
            
            define_method :it do
              target
            end
            
          end
          
          class_exec target, &block
        end
      end
      
      # @param [Integer] int
      # @return [String]
      def format_sequence(int)
        raise RangeError, 'too big for counters' unless int < COUNTER_INT_MAX
        int.to_s(COUNTER_FORMAT_BASE_NUMBER).rjust(COUNTER_FORMAT_LENGTH, '0').upcase
      end

    end

  end

end
