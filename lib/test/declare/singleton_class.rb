require 'test/unit'
require_relative 'exceptions'

module Test; module Declare

  class << self

    def new_test_case(target, case_desc=nil, &block)

  Class.new Test::Unit::TestCase do

    singleton_class.class_eval do

      define_method :it do
        target
      end

      define_method :is do |other, desc=nil|

        define_method :"test_#{target}_#{__callee__}_#{other}" do
          assert_equal other, target, desc
        end

        define_method :"test_#{other}_#{__callee__}_#{target}" do
          assert_equal target, other, desc
        end

      end

      define_method :same do |other, desc=nil|

        define_method :"test_#{target}_#{__callee__}_#{other}" do
          assert_same other, target, desc
        end

        define_method :"test_#{other}_#{__callee__}_#{target}" do
          assert_same target, other, desc
        end

      end

      define_method :kind_of do |other, desc=nil|

        define_method :"test_#{target}_is_#{__callee__}_#{other}" do
          assert_kind_of other, target, desc
        end

        define_method :"test_#{target.inspect}'s class_is_member_of_#{other}'s ancestors" do
          assert_same true, target.class.ancestors.include?(other), desc
        end

      end

      define_method :is_a do |other, desc=nil|

        define_method :"test_#{target}_#{__callee__}_#{other}" do
          assert_instance_of other, target, desc
        end

        define_method :"test_#{target}'s class_is_#{other.class}" do
          assert_same other, target.class, desc
        end

      end

    end

    define_method :setup do
      @it = target
    end

    class_exec target, &block
    
  end

    end

  end

end; end
