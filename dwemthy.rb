#!/usr/bin/env ruby

class Creature

	#Get a metaclass for this class
	def self.metaclass; class << self; self; end; end;

	#Advanced metaprogramming code for nice, clean traits
	def self.traits( *arr )
		return @traits if arr.empty?

		#Set up accessors for each variable
		attr_accessor *arr

		#Add a new class method for each trait
		arr.each do |a|
			metaclass.instance_eval do
				define_method( a ) do |val|
					@traits ||= {}
					@traits[a] = val
				end
			end
		end

		# For each monster, the 'initialize' method
		# should use the default number for each trait
		class_eval do
			define_method( :initialize ) do
				self.class.traits.each do |k,v|
					instance_variable_set("@#{k}",v)
				end
			end
		end
	end

	def hit( damage )
		p_up = rand( charisma )
		if p_up % 9 == 7
			@life += p_up / 4
			puts "[#{ self.class } magic powers up #{ p_up }!]"
		end
		@life -= damage
		puts "[#{ self.class } has died.]" if @life <= 0
	end

	def fight( enemy, weapon )
		if life <= 0
			puts "[#{ self.class } is too dead to fight!]"
			return
		end
		
		your_hit = rand( strength + weapon )
		puts "[You hit with #{ your_hit } points of damage!]"
		enemy.hit( your_hit )

		p enemy
		if enemy.life > 0
			enemy_hit = rand( enemy.strength + enemy.weapon )
			puts "[Your enemy hit with #{ enemy_hit } points of damage!]"
			self.hit( enemy_hit )
		end
	end

	traits :life, :strength, :charisma, :weapon
end

class Dragon < Creature
	life 1340
	strength 451
	charisma 1020
	weapon 939

	def method_missing(args)
		puts "Dragon has no #{ args } such method"
	end

end

class IndustrialRaverMonkey < Creature
life 46
strength 35
charisma 91
weapon 2
end

class DwarvenAngel < Creature
life 540
strength 6
charisma 144
weapon 50
end

class AssistantViceTentacleAndOmbudsman < Creature
life 320
strength 6
charisma 144
weapon 50
end

class TeethDeer < Creature
life 655
strength 192
charisma 19
weapon 109
end

class IntrepidDecomposedCyclist <
Creature
life 901
strength 560
charisma 422
weapon 105
end

class Dragon < Creature
life 1340     # tough
strength 451  #
charisma 1020 #
weapon 939    #
end

class DwemthysArray < Array
	alias _inspect inspect
	def inspect; "#<#{ self.class }#{ _inspect }>"; end
	def method_missing( meth, *args )
		answer = first.send( meth, *args )
		if first.life <= 0
			shift
			if empty?
				puts "[Whoa. You decimated Dwemthy's Array!]"
			else
				puts "[Get ready. #{ first.class } has emerged.]"
			end
		end	
		answer || 0
	end
end

class NameCaller
	def method_missing( name, *args )
		puts "You're calling `" + name.to_s + "' and you say:" 
		args.each { |say| puts "  " + say }
		puts "But no one is there yet." 
	end
	def deirdre( *args )
		puts "Deirdre is right here and you say:" 
		args.each { |say| puts "  " + say }
		puts "And she loves every second of it." 
		puts "(I think she thinks you're poetic.)" 
	end
end
