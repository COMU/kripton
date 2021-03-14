#!/usr/bin/python3
""" Solution for Project Euler Problem 668:
Square root smooth Numbers. https://projecteuler.net/problem=668
"""


def find_all_primes_until(n):
    primes = []
    for number in range(2, n+1):
        is_prime = True
        number_square_root = number ** (1/2.0)
        for prime in primes:
            if prime > number_square_root:
                break
            if number % prime == 0:
                is_prime = False
                break
        if is_prime:
            primes.append(number)
    return primes


def add_more(n, count, current, primes, last):
    for prime in primes:
        if prime < last:
            continue
        if current*prime > n:
            break
        else:
            if prime < current:
                count['c'] += 1
            add_more(n, count, current*prime, primes, prime)


if __name__ == "__main__":
    n = 10**8
    until = int(n**(1/2.0))
    primes = find_all_primes_until(until)
    count ={'c': 0 }
    for p1 in primes:
        for p2 in primes:
            if p2 >= p1:
                add_more(n, count, p1*p2, primes, max(p1, p2))
    print(count['c']+1)
