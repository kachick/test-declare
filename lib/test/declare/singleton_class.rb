require 'test/unit'
require_relative 'exceptions'
require_relative 'assertions'

module Test

  module Declare

    class << self

      # @return [Test::Unit::TestCase]
      def new_test_case(target, &block)
        Class.new ::Test::Unit::TestCase do
          extend Assertions
          
          singleton_class.class_eval do
            
            define_method :it do
              target
            end
            
          end
          
          class_exec target, &block
        end
      end

    end

  end

end
