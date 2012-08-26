require_relative 'singleton_class'

def The(target, case_desc=nil, &block)
  ::Test::Declare.new_test_case target, case_desc=nil, &block
end
