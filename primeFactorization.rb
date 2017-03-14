#Aaron Guillen
#Began October 2016


def primeFactors(x)
	#Begin with an empty array. We will populate this
	#with the prime factors of our argument x
	ret = Array.new 
	
	if x < 0 #If x < 0, reduce to a situation where x is positive
		x *= -1
	elsif x == 0 or x == 1
		return ret #Zero and one have no prime factors, return an empty set
	end
		
	y = 2
	
	#For all composite integers n, there exists a prime p such that
	#	p | n and p <= sqaureRoot(n)
	while y <= (Math.sqrt(x))
		#if y, our test variable, divides x, set x equal to x / y
		#and save y in our array, as it is a factor of x
		#Don't update y, because y may also divide x / y
		if x % y == 0
			x /= y
			ret.push(y)
		else #if y does not divide x, move on to y + 1
			y += 1
		end
	end
	
	ret.push(x)
end

def organizePrint(value)
	print value.to_s + " : 0x" + value.to_s(16) + " : ["
	t1 = Time.now
	primeFactors(value).each  { |x| print " " + x.to_s }
	print " ] : " + (Time.now - t1).to_s
	puts
end


=begin ... never got this to work the way I wanted it to
#All this is to make sure we can require this script in another script
#Or we can run it alone
if ARGV.length > 0
	#usage
	ARGV.each { |x| puts x }
	if ARGV[0].eql? "-h" or ARGV[0].eql? "--help"
		print "usage: ruby #{File.basename(__FILE__)} [option] [value] [value]\n"
		print "\tThis script calculates the prime factors of a given number\n"
		print "\tor range of numbers. It can be called with no options to require\n"
		print "\tthis script within another.\n"
		print "\n\t-h, --help displays this help message\n"
		print "\t-c, --calculate takes one integer value and computes the primitive roots, or\n"
		print "\t\ttakes two integer values and computes the primitive roots in that range"
		exit
	end
	if ARGV[0].eql? "-c" or ARGV[0].eql? "--calculate"
		if ARGV.length == 2
			organizePrint(ARGV[1].to_i(0))  #to_i(0) guesses the base, so we
			#can input numbers like 0xDEADBEEF and we get a correct answer	
		else ARGV.length == 3
			for i in ARGV[1].to_i(0)..ARGV[2].to_i(0)
				organizePrint(i)
			end
		end
	end
end
=end