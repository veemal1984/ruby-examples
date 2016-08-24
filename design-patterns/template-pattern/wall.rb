# Template Pattern
# @Authur: Vimal
# Reference : http://dalibornasevic.com/posts/9-ruby-singleton-pattern

# The template method pattern is a behavioral design pattern that defines the program skeleton of an algorithm in an operation, defering some steps to subclasses

# In the template method of this design pattern, 
# one or more algorithm steps can be overridden by subclasses
# to allow differing behaviors while ensuring that the overarching algorithm is still followed.

# Template class
# In ruby since we dont have abtract class
# we achieve the behaiviour of abstract class by using raise method
class Wall
   def length
   	raise NotImplementedError, 'Ask the subclass'
   end
   def width
   	raise NotImplementedError, 'Ask the subclass'
   end
   def material
   	raise NotImplementedError, 'Ask the subclass'
   end 
end

# Subclass which will override the template methods.
class BrickWall < Wall  
   def material
     'Brick'
   end

   def length
   	'10 m'
   end

   def width
   	'5 m'
   end
end

class IronWall < Wall
   def material
     'iron'
   end

   def length
   	'10 m'
   end

   def width
   	'5 m'
   end
end