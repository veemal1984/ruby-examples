# Observer Pattern
# @Authur: Vimal
# Reference : https://dockyard.com/blog/2013/08/20/design-patterns-observer-pattern

# It is basically a mechanism for one object to inform other ‘interested’ objects when its state changes.

# The observer pattern (aka. Dependents, publish/subscribe)
# is a software design pattern in which an object, called the subject, 
# maintains a list of its dependents, called observers, and notifies them automatically 
# of any state changes, usually by calling one of their methods. 
# It is mainly used to implement distributed event handling systems.

# Method 1 using 'observer' module in ruby

class Notifier
	def update(car,miles)
	  puts "The car has logged #{miles} miles, totaling #{car.mileage} miles traveled."
	  puts "The car needs to be taken in for a service!" if car.service <= car.mileage
	end
end

require 'observer'
class Car
 include Observable

    attr_reader :mileage, :service
	def initialize(mileage = 0, service = 3000)
		@mileage, @service = mileage, service
		add_observer(Notifier.new)
	end
    def log(miles)
      @mileage += miles
      changed
      notify_observers(self,miles)
    end
end

#irb(main):076:0> car = Car.new
#=> #<Car:0x007fa3aa8ec0b0 @service=3000, @mileage=0, @observer_peers={#<Notifier:0x007fa3aa8ec060>=>:update}>
#irb(main):077:0> car.log(500)
#The car has logged 500 miles, totaling 500 miles traveled.
#=> false
#irb(main):078:0> car.log(5000)
#The car has logged 5000 miles, totaling 5500 miles traveled.
#The car needs to be taken in for a service!
#=> false


# Method 2 
# By Implemeting observer pattern on our own.


module Email
  extend self

  def send(subject, sender, receiver)
    puts %Q[
      Subject: #{subject}
      From:    #{sender}@example.com
      To:      #{receiver}@example.com
      Date:    #{Time.now.asctime}
    ]
  end
end

# Agent is the observer
class Agent
	# Here Gotcha is the update method we implemented
	def gotcha(person)
		puts "!!! TIME TO DETAIN #{person.name.upcase} !!!"
	end
end

# Alert is the observer here
class Alert
	def gotcha(person)
		puts "!!! ALERT: #{person.name.upcase} SENT AN EMAIL !!!"
	end
end

# Here is the observerable class ..........
class Subject
	attr_reader :observers

  def initialize
    @observers = []
  end

  def add_observer(*observers)
    observers.each { |observer| @observers << observer }
  end

  def delete_observer(*observers)
    observers.each { |observer| @observers.delete(observer) }
  end

  private

  def notify_observers
    observers.each { |observer| observer.gotcha(self) }
  end
end

class Person
  include Email, Subject
  attr_reader :name

  def initialize(name)
    # 'super' requires a parentheses because we're calling
    # super on the superclass, 'Subject'
    super()
    @name = name
  end

  def send_email(subject, receiver)
    Email.send(subject, name, receiver)
    notify_observers
  end
end


# Here is the Results
alert = Alert.new
agent = Agent.new

bill = Person.new 'Bill'

bill.add_observer alert, agent   # Bill now has two observers watching him

bill.send_email 'Fishing Trip', 'Fred'
  # =>
      Subject: Fishing Trip
      From:    Bill@example.com
      To:      Fred@example.com
      Date:    Wed Aug 16 20:35:09 2006

!!! ALERT: BILL SENT AN EMAIL !!!
!!! TIME TO DETAIN BILL !!!


