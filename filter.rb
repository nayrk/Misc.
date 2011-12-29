#!/usr/bin/env ruby

#module Enumerable
#	def group
#		letters = []
#		self.each do |x|
#			letters << x[0].chr
#		end
#		letters.sort!.uniq!
#		
#		letters.each do |x|
#			words = self.select do |y|
#				y[0].chr == x
#			end
#			yield x,words
#		end
#	end
#end
#
#x = ["abcd", "axyz", "able", "xyzab", "qrst"]
#x.group do |letter, words|
#	printf("%s: %s\n", letter, words.join(" "))
#end

class Adder
	attr_accessor :int
	
	def initialize i
		@int = i	
	end

	def method_missing( meth )
		if meth.to_s =~ /^plus(\d+)/
			#self.class returns Adder
			Adder.class_eval do
				define_method(meth) do
					@int + $1.to_i
				end
			end
			eval(meth.to_s)
		else
			super
		end
	end
end

a = Adder.new(10)
b = Adder.new(20)
p a.plus20
p b.plus20
p b.plus10
p a.plus10
p a.minus10
