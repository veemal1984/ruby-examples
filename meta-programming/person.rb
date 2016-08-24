# @Authur: Vimal
# Meta Programming Examples

class Person
  def name
  end
end

# MetaProgramming 
# Meta programming can be used as a way to add edit modify the code of your program while it is running.
# using it, you can make new or delete existing methods on objects, reopen
# or modify existing classes catch methods that dont's exist and avoid repetitious coding to keep your program DRY.

# Adding a class level method

#Method 1
class Person
  def name
  end

  def self.ishuman?
  true
  end
end

#Method 2
class Person

  def name
  end

 	class << self
 	 def ishuman?
 	   true
  end
 	end
end

# SingletonClass
# If only a single object requires an addition, alteration, or deletion?
# The “singleton class” (sometimes known as the “Eigenclass”),
# is designed exactly for this and allows you to do all that and more.

greeting = "i like cheese"

class << greeting
  def greet
  "Hello! " + self
  end
end

# This singleton class method allows you to add many methods 
# at once without having to prefix all of your method names(as in Method 1).
# This syntax also allows you to add anything you would normally 
# add during the declaration of a class, 
# including attr_writer, attr_reader, and attr_accessor methods.


# instance_eval and class_eval methods
# Having singleton classes is all good and well, but to truly work with objects 
# dynamically you need to be able to re-open them at runtime within other functions.
# Unfortunately, Ruby does not syntactically allow you to have any class statements within a function. 
# This is where instance_eval comes into the picture.

class Person
  def name
  end
end

Person.instance_eval do
  def ishuman?
    true
  end
end

irb(main):080:0> Person.ishuman?
=> true

Person.class_eval do
  def ishuman?
    true
  end
end

person = Person.new
irb(main):091:0> person.ishuman?
=> true

# As you can see, instance_eval and class_eval are very similar, 
# but their scope and application differs ever so slightly. 
# You can remember what to use in each situation by remembering 
# that you use instance_eval to make instance methods, 
# and use class_eval to make class methods.


