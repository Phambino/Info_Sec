#!/usr/bin/python3
import sys

# Bobs part of the Diffie Hellman Key Exchange
# call this with
# dhke_bob.py g p gamodp b

if not len(sys.argv) == 5:
	print("usage: dhke_bob g p gamodp b")
	exit(1)

g=int(sys.argv[1]) # This should really be a generator, but when p is large it likely will be 'good enough'
# For those interested, you might want to look at the following, not required for this course
# for more on this, see http://stackoverflow.com/questions/5656835/generator-gs-requirement-to-be-a-primitive-root-modulo-p-in-the-diffie-hellman
# For how to choose safe primes, see http://www.ietf.org/rfc/rfc4419.txt
# For 'standard choices' of p and g, see http://www.ietf.org/rfc/rfc3526.txt

p=int(sys.argv[2])
gamodp=int(sys.argv[3]) # that is, (g**a)%p which is g to the power a mod p
b=int(sys.argv[4]) # this should be a reasonable, large secret (between 2 and p)

# Alice sent Bob (=me) the following three things
print("Alice sent me g=", g)
print("Alice sent me p=", p)
print("Alice sent me (g**a)mod p=", gamodp)

print("I (=Bob) choose a secret b=", b)

modsecret=pow(g,b,p)  # FIX THIS, RENAME IT, GIVE IT THE RIGHT VALUE
print("I send Alice", modsecret)

shared_secret=pow(gamodp,b, p) # FIX THIS
print("Both Alice and I share the secret=", shared_secret)

