# coding: us-ascii

require 'test/unit'
require_relative 'exceptions'

module Test; module Declare

  module Assertions

    UNASSIGNED = Test::Unit::TestCase.const_defined?(:UNASSIGNED) ?
                 Test::Unit::TestCase::UNASSIGNED : ''

    def is(other, desc=nil)
      target = it
      define_method format_testname("#{summary_for target}_#{__callee__}_#{summary_for other}_(bidirectional)") do
        assert_equal other, target, desc
        assert_equal target, other, desc
      end
    end

    def is_not(other, desc=nil)
      target = it
      define_method format_testname("#{summary_for target}_#{__callee__}_#{summary_for other}_(bidirectional)") do
        assert_not_equal other, target, desc
        assert_not_equal target, other, desc
      end
    end
      
    def same(other, desc=nil)
      target = it
      define_method format_testname("#{summary_for target}_#{__callee__}_#{summary_for other}_(bidirectional)") do
        assert_same other, target, desc
        assert_same target, other, desc
      end
    end

    # @param [#eql?, #hash] other
    def eql(other, desc=nil)
      target = it
      define_method format_testname("#{summary_for target}_is_#{__callee__}_#{summary_for other},that_under_hash-key_matcher_(bidirectional)") do
        assert_same true, target.eql?(other), desc
        assert_same target.hash, other.hash, desc
        assert_same true, other.eql?(target), desc
        assert_same other.hash, target.hash, desc
      end
    end

    # @param [#===] other
    def match(other, desc=UNASSIGNED)
      target = it
      define_method format_testname("#{summary_for target}_#{__callee__}_under_#{summary_for other}") do
        assert(other === target, desc)
      end
    end

    # @param [Symbol, String] message
    def can(message, desc=nil)
      target = it
      message = message.to_sym
      define_method format_testname("#{summary_for target}_is_respond_to_#{message}") do
        assert_respond_to target, message, desc
      end
    end

    # @param [Module] mod
    def kind_of(mod, desc=nil)
      target = it
      define_method format_testname("#{summary_for target}_is_#{__callee__}_#{summary_for mod}") do
        assert_kind_of mod, target, desc
        assert_same true, target.class.ancestors.include?(mod), desc
      end
    end
    
    # @param [Class] cls
    def is_a(cls, desc=nil)
      target = it
      define_method format_testname("#{summary_for target}_#{__callee__}_#{summary_for cls}") do
        assert_instance_of cls, target, desc
        assert_same cls, target.class, desc
      end
    end

    def ok(desc=UNASSIGNED, &block)
      target = it         
      define_method format_testname("block(#{block.source_location})_pass_in_the_#{summary_for target}'s_context") do
        assert target.instance_exec(&block), desc
      end
    end

    def ng(desc=UNASSIGNED, &block)
      target = it
      define_method format_testname("block(#{block.source_location})_fail_in_the_#{summary_for target}'s_context") do
        assert !(target.instance_exec(&block)), desc
      end
    end

    # @param [Exception] error
    def CATCH(error, desc='', &block)
      define_method format_testname("block(#{block.source_location})_must_catch_a_exception \"#{error}\"") do
        assert_raise error, desc, &block
      end
    end

    private

    def summary_for(obj)
      /\A(.{,10}).*?(.{,10})?$/ =~ obj.inspect
      $2.empty? ? $1 : $~.captures.join('...')
    end

    def called_from
      caller.find{|s|%r![/\\]test_! =~ s}
    end

    def format_testname(body)
      :"test_#{body} ##{called_from}"
    end

  end

end; end
