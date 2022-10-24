#!/usr/bin/env python3

"""
This script contains some functions exemplifying the use of control statements
"""

__appname__ = ['control flow']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# imports
import sys


# functions
def even_or_odds(x=0):  # This x=0 is specified to run for default purposes

    """Find whether a number is odd or even."""
    if x % 2 == 0:
        return f"{x} is Even!"
    return f"{x} is Odd!"


def largest_divisor_five(x=120):

    """Find whether a number x is even or odd."""

    largest=0

    if x % 5 ==0:
        largest = 5
    elif x % 4 == 0:
        lergest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 == 0:
        largest = 2
    else:
        return f"No divisor found for {x}!"
    
    return f"The largest divisor of {x} is {largest}"


def is_prime(x=70):

    """Find whether an integer is prime."""

    for i in range (2, x):
        if x % i == 0:
            print(f"{x} is not a prime: {i} is a divisor")
            return False
    print(f"{x} is a prime!")
    return True


def find_all_primes(x=22):

    """Find all the primes up to x"""

    allprimes = []

    for i in range(2, x + 1):
        if is_prime(i):
            allprimes.append(i)

    print(f"There are {len(allprimes)} primes between 2 and {x}")
    return allprimes


def names(x="Vitor"):
    return f"Your name is {x}!"


def main(argv):
    print(even_or_odds(22))
    print(even_or_odds(55))
    #print(even_or_odds(int(argv[1])))  # Here we set argument to be tested
#                                        inside the function when provided
#                                        by the user
    print(even_or_odds(33))
    print(largest_divisor_five(120))
    print(largest_divisor_five(121))
    print(is_prime(60))
    print(is_prime(59))
    print(find_all_primes(100))
    print(names())
    return 0


if __name__ == "__main__":
    """Makes sure the "main" function is called from the CLI"""
    status = main(sys.argv)
    sys.exit(status)
 