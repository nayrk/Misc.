#!/usr/bin/ruby

shift = ARGV[0]
shift = shift.to_i

def pos(char)
	pos = 0
	('a'..'z').each do |l|
		pos += 1
		if char.downcase == l
			return pos.to_i
		end
	end
end

string="Max ybex bl t lmtgwtkw IhlmLvkbim ybex xgvkrimxw pbma t Ogxkgtf biaxk nlbgz t ebgxtk vhgzknxgmbte zxgxktmhk. Xtva uehvd bl xqtvmer lbqmaxxg ubml ghgz."

string = string.split('')

string.each do |l|
	l_pos = pos(l);
	decrypt = l_pos - shift;
	if decrypt < 0
		decrypt = 26 + decrypt
	end	
end
