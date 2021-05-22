test-declare
============

* ***This repository is archived***
* ***No longer maintained***
* ***All versions have been yanked from https://rubygems.org for releasing valuable namespace for others***

DSL wrapper for the "test/unit".

Feature
---

* Short and Small DSL, But he is a nosey helper :).
* Nest, Nest, Nest...

Usage
---

```ruby
# Product Code
class Person
  
  attr_reader :name, :birth
  
  def initialize(name)
    @name = name
    @birth = Time.now
  end

end

# Test Code
require 'test/declare'

The Person.new('John') do |john|
  is_a Person
  kind_of Object
  
  The john.name do
    kind_of String
    is_a String
    is 'Taro' # failure
    match /J/
  end

  The john.birth do
    kind_of Time
  end
end
```

```plain
  1) Failure:
test_"John"_is_"Taro" #bidirectional(#<Class:0x91f5690>)
<"Taro"> expected but was
<"John">.

7 tests, 12 assertions, 1 failures, 0 errors, 0 skips
```

Requirements
---

* Ruby 1.9.3 or later

License
=======

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.
