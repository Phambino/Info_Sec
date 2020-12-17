#!/usr/bin/python3
import random, sys
goodCharacters = ['\n', ' ', '!', '"', "'", '(', ')', ',', '-', '.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '?', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', ']', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

def encrypt(plaintext, key):
    random.seed(key)
    ciphertext = ""
    for j in range(len(plaintext)):
        c = plaintext[j]
        i = goodCharacters.index(c)
        i = (i + random.randrange(len(goodCharacters))) % len(goodCharacters)
        cp = goodCharacters[i]
        ciphertext = ciphertext + cp
    return ciphertext

# FIX THIS FUNCTION
def decrypt(ciphertext, key):
    random.seed(key)
    plaintext=""
    for j in range(len(ciphertext)):
        c = ciphertext[j]
        i = goodCharacters.index(c)
        i = (i - random.randrange(len(goodCharacters))) % len(goodCharacters)
        cp = goodCharacters[i]
        plaintext = plaintext + cp
    return plaintext


def usage(message):
    if message: print("{}: {}".format(sys.argv[0],message))
    print("usage: {} OP FILENAME KEY".format(sys.argv[0]))
    print("encrypt (OP=e) or decrypt (OP=d) FILENAME using KEY printing the result to stdout")

def arg_parse():
    # arg length
    if not len(sys.argv) == 4: 
        usage("wrong number of arguments supplied")
        exit(1)

    operation = sys.argv[1] # either e for encrypt or d for decrypt
    if operation not in ["e", "d"]: 
        usage("OP must be e or d")
        exit(1)

    filename = sys.argv[2] 

    try: 
        key = int(sys.argv[3]) # an integer
    except: 
        usage("KEY must be an integer")
        exit(1)
    return (operation, filename, key)


operation, filename, key = arg_parse()

fun = { "e" : encrypt, "d" : "decrypt" }
if operation=="e": fun = encrypt
if operation=="d": fun = decrypt

f = open(filename, "r")
print(fun(f.read(), key))
f.close()

