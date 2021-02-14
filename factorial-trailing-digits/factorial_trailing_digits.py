#!/usr/bin/python3
import time


def count_5s(number):
    counter = 0
    while (number % 5 == 0):
        counter += 1
        number /= 5
    return counter


def last_5_digits(number):
    number = number % (10 ** 5)
    return number


def factorial(number):
    borrowed_2s = 0
    product = 1
    for i in range(1, number+1):
        if i % 2 == 0:
            i = int(i/2)
            borrowed_2s += 1
        num_5s = count_5s(i)
        if num_5s:
            i = int(i/(5 ** num_5s))
            borrowed_2s -= num_5s
        product = last_5_digits(product * i)
    product *= (2 ** borrowed_2s)
    return product


def main(number):
    return last_5_digits(
        factorial(number)
    )


if __name__ == '__main__':
    n = 2560000
    start_time = time.time()
    result = main(n)

    print(
        "For {n}, took {time:.2f} seconds to find: {result}".format(
                **{'n': n, 'time': time.time() - start_time, 'result': result})
    )

