#!/usr/bin/env ruby

class MailTruck
	@trucks = []

	def self.add truck
		(@trucks ||= []) << truck
	end

	def list
		for truck in @trucks
			puts truck
		end
	end
end


#Do not do this =[... the class is unable to add objects to an instance variable (hence instance of)
#Use class variables instead if you want the Class itself to add to the variable..

#m = MailTruck.new
#MailTruck.add "Fedex"
#MailTruck.add "UPS"
#m.list

class String
	def encrypt
		tr "a-z", "b-za"
	end
end

class Fixnum
	def hours
		self * 3600
	end

	def from_now
		Time.now + self
	end

	#Changing/overloading previous function.. 
	def +( other )
		self * other	
	end
end

#This shows that a class is always run
class Test
	puts "hello"
	def hi
		puts "hell"
	end
end

#You can hold the class object in a variable
cls = Test
cls.new.hi


