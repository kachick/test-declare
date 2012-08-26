require 'test/unit'
require_relative 'exceptions'

module Test; module Declare

class << self

def new_test_case(target, case_desc=nil, &block)

## definitions

  Class.new ::Test::Unit::TestCase do

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

      define_method :is_not do |other, desc=nil|
        
        define_method :"test_#{target}_#{__callee__}_#{other}" do
          assert_not_equal other, target, desc
        end
        
        define_method :"test_#{other}_#{__callee__}_#{target}" do
          assert_not_equal target, other, desc
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

      define_method :eql do |other, desc=nil|
        
        define_method :"test_#{target}_is_eql_#{other},that_under_hash-key_matcher" do
          assert_same true, target.eql?(other), desc
          assert_same target.hash, other.hash, desc
        end

        define_method :"test_#{other}_is_eql_#{target},that_under_hash-key_matcher" do
          assert_same true, other.eql?(target), desc
          assert_same other.hash, target.hash, desc
        end
        
      end

      define_method :can do |other, desc=nil|
        message = other.to_sym

        define_method :"test_#{target}_is_respond_to_#{message}" do
          assert_same true, target.respond_to?(message)
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

      define_method :ok do |desc=nil, &block|
        
        define_method :"test_pass_a_block(#{block.source_location})_in_the_#{target}'_scope" do
          caller.reject!{|s|/singleton_class/=~s}
          assert target.instance_exec(&block)
        end        
        
      end

      define_method :ng do |desc=nil, &block|

        define_method :"test_fail_a_block(#{block.source_location})_in_the_#{target}'_scope" do
          assert !(target.instance_exec(&block))
        end
        
        
      end


      define_method :CATCH do |error, desc=nil, &block|

        define_method :"test_catch_a_exception, that is #{error}" do
          assert_raise error, dsec, &block
        end
        
      end

      
    end
    
    class_exec target, &block
    
  end

  ##

end

end

end; end
