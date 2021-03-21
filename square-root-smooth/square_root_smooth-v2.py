#!/usr/bin/python3
# -*- coding: utf-8 -*-

import primesieve

LIMIT,counter = 10**10, 0
R = int(LIMIT**(1/2))

for n in range(1, R+1):
    counter += primesieve.count_primes(n, LIMIT//n)

print(LIMIT-counter)
