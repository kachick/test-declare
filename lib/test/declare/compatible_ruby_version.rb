# coding: us-ascii

require 'test/unit'

unless RUBY_VERSION >= '1.9.3'

  module MiniTest; class Unit; class TestCase

    class << self

      remove_method :test_suites

      # This code from 1.9.3's minitest
      def test_suites # :nodoc:
        @@test_suites.keys.sort_by { |ts| ts.name.to_s }
      end

    end

  end; end; end

end
