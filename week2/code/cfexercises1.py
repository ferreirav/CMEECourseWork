#!/usr/bin/env python3

"""This script has a bunch of foo() fucntions"""

__appname__ = ['foo() functions module']
__author__ = 'Vitor Ferreira (f.ferreira2@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'Currently without license'


# Imports
import sys


# foo() functions
def foo_1(x=2, y=0.5):
    """
    This function calculates the power of an entered value
    """
    z = x ** y
    return f"The value of {x} to the power of {y} is: {z}"


# -------------
def foo_2(x=2, y=4):
    """
    This function gives the greatest number out of the two provided
    """

    if x > y:
        gt = x
    else:
        gt = y
    return f"The greatest number out of {x} and {y}, it is {gt}!!!"

# -------------
def foo_3(x=1, y=2, z=3):
    """
    This function will sort by numeric order the provided inputs
    """

    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return f"The random order of numbers are: {x, y, z}"
    # This function has a limitation when y is gt z


# -------------
def foo_4(x=5):
    """
    This function gives the product of the given input by the previous result
    calculated
    """

    result = 1
    for i in range(1, x + 1):
        result = result * i
    return f"The result of your input ({x}) with the last product calculated " \
           f"it is: {result}!!"


# -------------
def foo_5(x=5):
    """
    This function calculates the factorial
    """

    if x == 1:
        return 1
    return x * foo_5(x - 1)


# -------------
def foo_6(x=4):
    """
    This function calculates the factorial
    """

    facto = 1
    y = x
    while y >= 1:
        facto = facto * y
        y = y - 1
    return f"Another function that calculates the factorial of {x}: {facto}!!"


def main(argv):
    print(foo_1(2, 0.5))
    print(foo_2(2, 4))
    print(foo_3(1, 2, 3))
    print(foo_4(5))
    print(foo_5(5))
    print(foo_6(4))
    return 0


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
