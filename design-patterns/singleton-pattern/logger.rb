# Singleton Pattern
# @Authur: Vimal
# Reference : http://dalibornasevic.com/posts/9-ruby-singleton-pattern

# Singleton is a design pattern that restricts instantiation of a class to only one instance 
# that is globally available. It is useful when you need that instance to be accessible in different parts 
# of the application, usually for logging functionality, communication with external systems, database access, etc.

# Method 1
# Using pure Ruby
class Logger

  def initialize
     @log = File.open("logger.txt", "a")
  end

  @@instance = Logger.new

  def self.instance
     @@instance 
  end
  
  def log(message)
    @log.puts(message)
  end

  private_class_method :new
end

Logger.instance.log('message')

#This will raise a exception
Logger.new

# Method 2 
# Using Ruby Singleton Mixin
# Ruby Singleton module
# Ruby Standard Library has a Singleton module which implements 
# the Singleton pattern. Previous example when using the Singleton module would translate to:
require 'singleton'
class Logger
 include 'singleton'

 def intialize
   @log = File.open("logger.txt", "a")
 end

def log(message)
   @log.puts(message)
end  

end

Logger.instance.log('message')

#This will raise a exception
Logger.new

# Method 3
# Using Class variable
module Logger
  def self.log(msg)
    @@log ||= File.open("log.txt", "a")
    @@log.puts(msg)
  end
end

#Singleton Pattern used in Rails
#Rails is using the singleton pattern to implement class Inflections. It is a single instance (Inflections.instance) that gives global access to all inflection rules used in different parts of Rails.


