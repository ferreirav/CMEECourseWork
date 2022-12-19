#!/usr/bin/env python3

"""Script with profile improvement by using list comprehensions and concatenation!!"""

__appname__ = ['profileme2']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Functions
def my_squares(iters):
    """Returns the square of a number"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """Append to the string"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """Concatenation of the two given vectors"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")