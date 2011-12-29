#!/usr/bin/env ruby

#require 'thread'
#require 'net/http'
#require 'open-uri'
#
#threads = []
#
#urls = %w( www.google.com www.yahoo.com www.ucr.edu) 
#
#urls.each do |l|
#	threads << Thread.new do
#		open("http://"+l).each_line do |x|
#			puts x
#		end
#	end
#end
#
#threads.each { |t| t.join }

require 'thread'

class BankAccount  
	def initialize(name, checking, savings)  
		@name,@checking,@savings = name,checking,savings  
	end  

	def transfer_from_savings(x)  
		@savings -= x  
		@checking += x  
	end  

	def report  
		"#@name\nChecking: #@checking\nSavings: #@savings"  
	end  
end 

count = 0
t1 = Thread.new { 
		while count < 50
			count += 1
			puts count
		end
		}

t2 = Thread.new { 
		while count > 20
			count -= 1
			puts count
		end
}
