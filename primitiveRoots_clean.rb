require_relative 'eulersTotient'
require_relative 'primeFactorization'

def findPrimitiveRoots_prime(p)
	if p < 2 
		return -1 
	end
	
	if p == 2
		return [1]
	end

	s = phi(p)
	
	primeFact = primeFactors(s).uniq 
	
	powers = []
	primeFact.each { |y| powers.push(s / y) }
	
	continue = true 
	count = 2
	while continue do
		continue = false 
		for i in powers
			if count ** i % p == 1 and not continue
				continue = true 
				break
			end
		end
		if continue 
			count += 1
		end
	end
	
	primitiveRoots = [] 
	for m in 1..(p - 1)
		if euclideanAlg(m, (p - 1)) == 1
			primitiveRoots.push ((count ** m) % p)
		end
	end
	
	return primitiveRoots
end

def gcdPrimeFactors(a, b)
	
	commonFactors = commonFactors(primeFactors(a), primeFactors(b))
	
	if commonFactors == []
		return 1 
	end
	
	product = 1
	commonFactors.each { |y| product *= y }
	return product
end

def commonFactors(setX, setY)
	commonFactors  = [] 
	
	setX.each do |xElement|
		if setY.include? xElement 
			commonFactors.push xElement 
			setY.delete_at setY.index xElement
		end
	end
	return commonFactors
end

def euclideanAlg(a, b)
	if b > a 
		a ^= b
		b ^= a
		a ^= b
	end
	if b < 1 
		return -1 
	end
	
	q = a / b 
	r = a - b * q 
	
	if r == 0
		return b
	end
	euclideanAlg(b, r)
end

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