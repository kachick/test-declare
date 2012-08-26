require_relative 'singleton_class'

# @return [Test::Unit::TestCase]
def The(target, &block)
  ::Test::Declare.new_test_case target, &block
end
