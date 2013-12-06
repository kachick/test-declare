# coding: us-ascii

require_relative 'test_helper'

The(Array) { 
  is_a       Module
  kind_of    Hash
  can :undefined_foooo_method
  
  The(it.new) {
    is_a Hash
  }
}

The(1) {
  is      1.1
  is      2
  ng     {self == 2.to_r}
  match   2..3
  same   1.0
  kind_of    Float
  is_a       Integer
  can :undefined_foooo_method

  CATCH RuntimeError do
    raise Exception
  end
}
