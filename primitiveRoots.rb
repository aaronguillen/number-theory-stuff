require_relative 'eulersTotient'
require_relative 'primeFactorization'

#The following function finds the primitive roots of
#a prime number
#Theory/algorithm taken from
#http://math.stackexchange.com/questions/124408/finding-a-primitive-root-of-a-prime-number
def findPrimitiveRoots_prime(p)
	if p < 2 #Let's not bother with anything less than 2
		return -1 #ERROR
	end

	#Everything below works for odd primes. For our only even prime ...
	if p == 2
		return [1]
	end

	#First, let s = phi(x)
	#if p is prime, s = p - 1, but
	#let's let our phi function deal with that
	s = phi(p)
	
	#Then, you need to determine all the (unique) prime
	#factors of s
	primeFact = primeFactors(s).uniq #Get a list of the unique prime factors
	
	#So, we have phi(x) = s and the unique prime factors of s
	#Now we need to calculate s divided by each of its unique prime factors
	powers = []
	primeFact.each { |y| powers.push(s / y) }
	
	continue = true #Do we continue looking for the least primitive root?
	count = 2
	while continue do
		continue = false #assume we'll find our primitive root
		for i in powers
			if count ** i % p == 1 and not continue
				continue = true #Not a primitive root
				break
			end
		end
		if continue #update count if we haven't found our root
			count += 1
		end
	end
	#After the above loop, we should have found our least primitive root
	
	#If a is a primitive root mod p (in this case, count), and p is prime
	#Then a^m mod p is a primitive root mod p for 1 <= m <= p - 1 and
	#gcd(m, p - 1) = 1; that is, m and (p - 1) are relatively prime (a.k.a coprime)
	primitiveRoots = [] #count is our first primitive root mod x
	for m in 1..(p - 1)
		if euclideanAlg(m, (p - 1)) == 1
			primitiveRoots.push ((count ** m) % p)
		end
	end
	
	return primitiveRoots
end

#We're going to define two functions for finding the GCD of two numbers
#Theory for both is taken from a book:
#Introduction to Cryptography with Coding Theory Second Edition
#By Wade Trappe and Lawrence C. Washington
#The purpose of this is to determine relative primality;
#That is, whether or not the GCD of two numbers is equal to 1
#If GCD of two numbers a and b is 1 (viz., gcd(a, b) = 1), we say
#these numbers are relatively prime
#NOTE: relative primality is also referred to as coprimality or mutual primality

#Our first GCD function uses our primeFactorization algorithm
#If two numbers share a prime factor, they are not relatively prime
def gcdPrimeFactors(a, b)
	#We get the common prime factors of our two values
	commonFactors = commonFactors(primeFactors(a), primeFactors(b))
	
	#If we have an empty list, our number have no common
	#factors are are relatively prime
	if commonFactors == []
		return 1 #Relative primality: gcd(a, b) = 1
	end
	#otherwise, the gcd of our two numbers is the product
	#of our list of common factors
	product = 1
	commonFactors.each { |y| product *= y }
	return product
end

#A supporting method for gcdPrimeFactors
#I know it is inelegant, but it's the only
#Way I could think of to get the common factors
#From our lists
def commonFactors(setX, setY)
	commonFactors  = [] #Begin with an empty set
	
	setX.each do |xElement|
		if setY.include? xElement #If we have a matching element
			#Add our value to our list of common factors
			commonFactors.push xElement 
			#Remove it from our setY so we don't check it again
			setY.delete_at setY.index xElement
		end
	end
	return commonFactors
end

#I would also like to define another method for determining GCD
#This is the Euclidean Algorithm
#Note again, this is taken from the book cited above
#AND I made it recursive because, well, that's just fun
def euclideanAlg(a, b)
	#Suppose that a is greater than b.
	#If not, switch and and b
	if b > a #I use the XOR swap algorithm here because I like it
		a ^= b
		b ^= a
		a ^= b
	end
	
	if b < 1 #If be is zero or negative
		return -1 #ERROR
	end
	
	#Now we divide a by b and represent a in the form a = qb + r
	#Where q and r are integers such that 0 <= r < b
	q = a / b #Integer division
	r = a - b * q #Get the remainder
	
	if r == 0
		return b
	end
	euclideanAlg(b, r)
end

#Determine whether or not two integers are relatively prime
def isCoprime(a, b)
	if euclideanAlg(a, b) > 1
		return false
	end
	return true
end

def usage()
	print "usage: ruby #{File.basename(__FILE__)} [value]\n"
	print "\tThis script calculates the primitive roots of a prime number\n"
	exit(0)
end

def main()
	if ARGV.length == 1
		print findPrimitiveRoots_prime(ARGV[0].to_i(0)).sort
	else
		usage()
	end
end

main()