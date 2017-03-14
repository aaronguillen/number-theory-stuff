#Phi Function/Euler's totient function
#http://www.geeksforgeeks.org/eulers-totient-function/
def phi(x)
	#Don't bother with numbers less than one
	if x < 1
		return -1 #Return error code
	end
	
	require_relative 'primeFactorization'
	
	primeFact = primeFactors(x).uniq
	
	#And since Euler's totient function is a function of the 
	#product of our value and (1 - (1 / p)) for each p where p
	#is a unique prime factor of our x 
	primeFact.each { |y| x *= (1.0 - (1.0 / y)) }
	return x.to_i
end

=begin .. never quite got to this work like I wanted it to
#All this is to make sure we can require this script in another script
#Or we can run it alone
if ARGV.length > 0 and ARGV.length < 3
	#usage
	if ARGV[0].eql? "-h" or ARGV[0].eql? "--help"
		print "usage: ruby #{File.basename(__FILE__)} [option] [value]\n"
		print "\tThis script calculates euler's totient of a given number\n"
		print "\tIt can be called with no options to require\n"
		print "\tthis script within another.\n"
		print "\n\t-h, --help displays this help message\n"
		print "\t-c, --calculate takes one integer value and computes euler's totient\n"
		exit
	end
	if ARGV[0].eql? "-c" or ARGV[0].eql? "--calculate"
		print phi(ARGV[1].to_i(0)) #to_i(0) guesses the base, so we
		#can input numbers like #0xDEADBEEF and we get a correct answer
	end
end
=end