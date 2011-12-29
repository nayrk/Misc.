#!/usr/bin/env ruby

module ActiveRecord
	class Base
		def self.set_table_name(new_name)
			@table_name = new_name
		end
		
		#Called when this class is inherited 
		def self.inherited(subclass)
			#subclass is the inheritors' name
			name = subclass.name.downcase + "s"
			#Receiver is currently ActiveRecord::Base.. change to subclass
			#*** Very Subtle ***
			subclass.set_table_name(name)
		end
	end
end

# class < Module::Class
class Book < ActiveRecord::Base
	set_table_name :volumes
end


# ********************************** MODULE *******************************
# A Module is basically a class with instance methods that can't be called
# however, they can be extended/included in a class and then used
#
#
# ************************ Include vs Extend ******************************
#
# module Dave
# 	def hi
# 		puts 'hello'
# 	end
# end
#
# ================================
#
# class Fred
#
# 	# This makes class methods
# 	self.extend Dave
# end
#
# Fred.hi
#
#=================================
#
# class Fred
#	
#	# This makes object methods
#	include Dave
# end
#
# Fred.new.hi

# Binding doesn't allow you to change the value
# def evaluator(str, binding)
# 	a_value = 123
# 	eval(str, binding)
# end
# 
# str = "puts a_value"
# a_value = 321
# evaluator(str, binding)
#

# Closure	
# def proc_scope
# 	name = "Ruby"
# 	lambda { puts "Name is: #{name}" }
# end
# 
# tp = proc_scope
# tp.call
