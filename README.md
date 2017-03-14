# number-theory-stuff

Alright, so I wanted to solve the problem of finding all the primitive roots of a given integer.

I still haven't solved that problem, yet.

But, I did write up some code to determine the primitive roots of a prime number.

Let's begin with a citation:
http://math.stackexchange.com/questions/124408/finding-a-primitive-root-of-a-prime-number

User Vadim provided an example on math.stackexchange.com that became the algorithm I coded. Now, don't get me wrong; I'm sure I'm not the first one to code this algorithm and I'm sure I didn't come upon any of these ideas independently. I did, however, try to do as much of this from scratch as possible, and you will see in my comments in the code and in this readme that I will cite my sources as accurately as possible.

The algorithm I derived from Vadim abstracts like so:
- Take a prime number p
- Let s = phi(p) where phi() is Euler's Totient Function
- Determine all prime factors of s = phi(p)
- Choose a number 1 < a < (p - 1) to test as a primitive root
- For each prime factor f of s, calculate a^(s/f) mod p
- If any of these calculations yeild 1, a is not a primitive root mod p. Otherwise, a is a primitive root mod p
- That is:
    for some p prime
    s = phi(p)
    for some a such that 1 < a < (p - 1)
    for all f such that f is a prime factor of s
    if a^(s/f) = 1 mod p
      a is not a primitive root mod p
    else
      a is a primitive root mod p
- Once you have one primitive root mod p, the remainder of the the primitive roots mod p can be found as such:
  - for all m such that 1 <= m <= (p - 1) where gcd(m, (p - 1)) = 1
    That is, for all 1 <= m <= (p - 1) where m and (p - 1) are coprime
  - a ^ m mod p is another primitive root mod p

Now, as you can see this isn't a particularly intensive algorithm. The problem I ran into was the subroutines.

Euler's Totient was simple enough, and I cite my implemenation of the function below:
http://www.geeksforgeeks.org/eulers-totient-function/

I actually already have a prime factorization program on github, which you can see here https://github.com/aaronguillen/prime-factorization
I used the ruby version of that program almost exactly, with a few minor changes.

In terms of deciding which integer a to test as a primitive root, I took the course of finding the least primitive root mod p: start testing at a = 2 and move up from there.

Once I found the first primitive root mod p, then came the challenge of finding the rest of them. This required writing an algorithm to find the greatest common denominator between two integers. For this, I turned to a book called Introduction to Cryptography with Coding Theory Second Edition by Wade Trappe and Lawrence C. Washington. Here's the MLA citation for it:

Trappe, Wade, and Lawrence C. Washington. Introduction to Cryptography: With Coding Theory. New Jersey, Estados Unidos: Pearson Education, 2006. Print

Anyway, you can see the two gcd algorithms in the code. I use the Euclidean Algorithm in practice because I believe it is faster; I included the prime factorization algorithm for the sake of completion and because, well, I already had a prime factorization algorithm and it was cool to have another application for it.

--------------------------------

Anyway, that's the code. The version of Ruby I used is:
ruby 2.3.1p112 (2016-04-26 revision 54768) [x64-mingw32]

And I developed it on a machine with the following specifications:
Windows 10 64-bit
Intel Core i7-3612QM CPU @ 2.10GHz
8.00 GB RAM

--------------------------------

As for the files included, here, we have:

primeFactorization.rb
Which, again, was originally coded here https://github.com/aaronguillen/prime-factorization/blob/master/primeFactorization.rb

eulersTotient.rb
The Eulers Totient Function script

primitiveRoots.rb
The whole thing ... so far.

---------------------------------

TODO:
I still would like to write a script to find the primitive root of any given integer. I do understand that no efficient algorithm exists to achieve this, but I'd like to write an inefficient algorithm, just because I like number theory that much.

I also need to find a way to allow primeFactorization.rb and eulersTotient.rb to be standalone, but still allow them to be required for use in another script. Uncomment the block comments at the bottom of each script and run primitiveRoots.rb and you'll see what I mean.

Make the output and usage and just general not math related stuff for primtiveRoots.rb a little prettier.
