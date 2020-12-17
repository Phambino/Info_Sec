#!/bin/python3
import random, sys

def frequency(filename, plaintextAlphabet):
    freq = { p:0 for p in plaintextAlphabet }
    f = open(filename, "r")
    for line in f:
        for p in line:
            if p not in plaintextAlphabet: continue
            freq[p]+=1
    f.close()
    return freq

plaintextAlphabet = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
filename = sys.argv[1]
print(filename)
freq = frequency(filename, plaintextAlphabet)
freq = {k: v for k, v in sorted(freq.items(), key=lambda item: item[1])}
print(freq)

