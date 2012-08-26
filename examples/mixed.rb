require_relative 'test_helper'

class Person
  
  attr_reader :name, :birth
  
  def initialize(name)
    @name = name
    @birth = Time.now
  end

end


The Person.new('John') do |john|

  is_a Person
  kind_of Object
  
  The john.name do |name|
    kind_of String
    is_a String
    is 'Taro' # failer
    match /J/
  end

  The john.birth do
    kind_of Time
  end

end
