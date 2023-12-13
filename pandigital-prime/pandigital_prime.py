#!/usr/bin/python3
""" Solution for Project Euler Problem 41:
Pandigital prime. https://projecteuler.net/problem=41
"""

def find_primes_until(n):
  """Find all prime numbers until n by saving previous primes and
  checking next number against them.
  """
  primes = []
  for candidate in range(2, n):
    is_prime = True
    c_sqrt = candidate ** (1/2)
    for prime in primes:
      if prime > c_sqrt:
        break
      if candidate % prime == 0:
        is_prime = False
        break
    if is_prime:
      primes.append(candidate)
  return primes


def is_prime(c, primes):
  """Check if c is prime by checking c against primes in list
  """
  c_sqrt = c ** (1/2)
  for prime in primes:
    if prime > c_sqrt:
      break
    elif c % prime == 0:
      return False
  return True


def ndigit_pandigitals(n):
  """Yields all n-digit pandigital numbers from high to low
  """

  def add_numbers(n, lst=[]):
    """We keep adding numbers recursively wrt pandigital rule.
    """
    if len(lst) == n:
      yield int("".join(map(lambda x: str(x), lst)))
    else:
      for i in range(n, 0, -1):
        if i in lst:
          continue
        else:
          lst.append(i)
          for c in add_numbers(n, lst):
            yield c
          lst.pop()

  for final_number in add_numbers(n):
    yield final_number


def main():
  """Check all 9-digit, 8-digit ... 1-digit pandigitals.
  Return first prime one.

  NOTE: Sums of all digits of all 9-digit and 8-digit
  pandigitals are dividable by 3. So, they can be ignored
  from iteration. We still check them because code runs fast:)
  """
  primes = find_primes_until(int(987654321**(1/2)) + 1)
  for n in range(9, 0, -1):
    for pandigital in ndigit_pandigitals(n):
      if is_prime(pandigital, primes):
        return pandigital


result = main()
print("Biggest n-digit pandigital prime is %s" % result)
