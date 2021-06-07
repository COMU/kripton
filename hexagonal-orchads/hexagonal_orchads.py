#!/usr/bin/python3

from sympy.ntheory.factor_ import totient


def count_blinds_in_triangle(n):
    total = 0
    for level in range(2, ((n+1)//2)+1):
        t = totient(level)
        total += t * (int(n / level) - 1)
        if level % 10000 == 0:
            print("%{:.2f}".format((level/n)*100))
    return total


def main(n):
    blinds_in_triangle = count_blinds_in_triangle(n)
    total = 6 * blinds_in_triangle + 6 * (n - 1)
    return total


if __name__ == '__main__':
    # takes about 2.5 hours to calculate 100 million
    n = 100000000
    total_blinds = main(n)
    print('total blind points: %s' % total_blinds)