#!/usr/bin/env ruby

require 'thread'

class BankAccount  
	def initialize(name, checking, savings)  
		@name,@checking,@savings = name,checking,savings  
		@lock = Mutex.new  # For thread safety  
	end  

	def transfer_from_savings(x)  
		@lock.synchronize {  
			@savings -= x  
			@checking += x  
		}  
	end  

	def report  
		@lock.synchronize {  
			"#@name\nChecking: #@checking\nSavings: #@savings"  
		}  
	end  
end 

ba = BankAccount.new( "Ryan", 0, 400 )

threads = []
%w(5 5 5 5 5).each do |x|
	threads << Thread.new { ba.transfer_from_savings(x.to_i)	}
end

threads.each do |t| t.join end
puts ba.report
