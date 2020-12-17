#!/bin/python3
import random, sys

def encryptChar(p, key, plaintextAlphabet):
    try:
        i = plaintextAlphabet.index(p)
        c = key[i:i+1]
    except:
        c = p
    return c

def encryptFile(filename, key,plaintextAlphabet):
    f = open(filename, "r")
    for line in f:
        line = line.lower()
        m = ""
        for p in line:
            if p not in plaintextAlphabet: continue
            c = encryptChar(p,key,plaintextAlphabet)
            m = m + c
        print(m)
    f.close()

def generateKey(plaintextAlphabet):
    key = list(plaintextAlphabet)
    random.shuffle(key)
    key = ''.join(key)
    return key

plaintextAlphabet = "abcdefghijklmnopqrstuvwxyz0123456789"
key = generateKey(plaintextAlphabet)
plaintextAlphabet = plaintextAlphabet + " "
key = key + " "
print("key:{}:".format(key))
filename = sys.argv[1]
encryptFile(filename, key, plaintextAlphabet)

