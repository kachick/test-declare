require_relative 'test_helper'

The(Array) {  
  is_a    Class
  kind_of Module
  can :new
}

The(1) {
  is      1.0
  is      1.to_r
  ng     {self == 2}
  match   1..3
  kind_of    Integer
  is_a       Fixnum
  can :upto
  
  CATCH NoMethodError do
    this_is_a_undefined_method!
  end
  
}

