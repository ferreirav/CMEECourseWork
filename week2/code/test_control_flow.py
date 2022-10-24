#!/usr/bin/env python3

"""
This script contains some functions exemplifying the use of control statements
"""

__appname__ = ['control flow']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'

# imports
import sys
import doctest


# functions
def even_or_odd(x=0):

    """Find whether a number is odd or even.

    >>> even_or_odd(10)
    '10 is Even!'

    >>> even_or_odd(5)
    '5 is Odd!'
    
    whenever a float is provided, then the closest integer is used:    
    >>> even_or_odd(3.7)
    '4 is Even!'
    
    in case of negative numbers, the positive is taken:    
    >>> even_or_odd(-4)
    '-4 is Even!'
    
    """

    # Defining function to be tested
    x = round(x, 0) # rounding the integer to its closest absolute number
    x = int(x) # transforming it into integer
    if x % 2 == 0:
        return f"{x} is Even!"
    else:
        return f"{x} is Odd!"


def main(argv):
    print(even_or_odd(22))
    print(even_or_odd(33))
    return 0


if __name__ == "__main__":
    status = main(sys.argv)


# Testing functions with provided examples
doctest.testmod()
