require 'test/unit'
require_relative 'exceptions'

module Test; module Declare

  module Assertions

    UNASSIGNED = Test::Unit::TestCase::UNASSIGNED

    def is(other, desc=nil)
      target = it
      define_method :"test_#{summary_for target}_#{__callee__}_#{summary_for other}" do
        assert_equal other, target, desc
      end
      
      define_method :"test_#{summary_for other}_#{__callee__}_#{summary_for target}" do
        assert_equal target, other, desc
      end
    end

    def is_not(other, desc=nil)
      target = it
      define_method :"test_#{summary_for target}_#{__callee__}_#{summary_for other}" do
        assert_not_equal other, target, desc
      end
        
      define_method :"test_#{summary_for other}_#{__callee__}_#{summary_for target}" do
        assert_not_equal target, other, desc
      end    
    end
      
    def same(other, desc=nil)
      target = it
      define_method :"test_#{summary_for target}_#{__callee__}_#{summary_for other}" do
        assert_same other, target, desc
      end
        
      define_method :"test_#{summary_for other}_#{__callee__}_#{summary_for target}" do
        assert_same target, other, desc
      end  
    end

    def eql(other, desc=nil)
      target = it
      define_method :"test_#{summary_for target}_is_eql_#{summary_for other},that_under_hash-key_matcher" do
        assert_same true, target.eql?(other), desc
        assert_same target.hash, other.hash, desc
      end

      define_method :"test_#{summary_for other}_is_eql_#{summary_for target},that_under_hash-key_matcher" do
        assert_same true, other.eql?(target), desc
        assert_same other.hash, target.hash, desc
      end  
    end

    # @param [#===] other
    def match(other, desc=UNASSIGNED)
      target = it
      define_method :"test_#{summary_for target}_#{__callee__}_under_#{summary_for other}" do
        assert(other === target, desc)
      end
    end

    def can(other, desc=nil)
      target = it
      message = other.to_sym

      define_method :"test_#{summary_for target}_is_respond_to_#{message}" do
        assert_respond_to target, message, desc
      end
    end
      
    def kind_of(other, desc=nil)
      target = it
      define_method :"test_#{summary_for target}_is_#{__callee__}_#{summary_for other}" do
        assert_kind_of other, target, desc
      end

      define_method \
      :"test_#{summary_for target}'s class_is_member_of_#{summary_for other}'s ancestors" do
        assert_same true, target.class.ancestors.include?(other), desc
      end
    end
    
    def is_a(other, desc=nil)
      target = it
      define_method :"test_#{summary_for target}_#{__callee__}_#{summary_for other}" do
        assert_instance_of other, target, desc
      end
       
      define_method :"test_#{summary_for target}'s class_is_#{summary_for other.class}" do
        assert_same other, target.class, desc
      end 
    end

    def ok(desc=UNASSIGNED, &block)
      target = it         
      define_method \
      :"test_pass_a_block(#{block.source_location})_in_the_#{summary_for target}'s_context" do
        assert target.instance_exec(&block), desc
      end        
    end

    def ng(desc=UNASSIGNED, &block)
      target = it
      define_method \
      :"test_fail_a_block(#{block.source_location})_in_the_#{summary_for target}'s_context" do
        assert !(target.instance_exec(&block)), desc
      end
    end

    def CATCH(error, desc='', &block)
      define_method :"test_the_block(#{block.source_location})_must_catch_a_exception \"#{error}\"" do
        assert_raise error, desc, &block
      end
    end

    private

    def summary_for(obj)
      /\A(.{,10}).*?(.{,10})?$/ =~ obj.inspect
      $2.empty? ? $1 : $~.captures.join('...')
    end

  end

end; end
