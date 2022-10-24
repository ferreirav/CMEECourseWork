#!/usr/bin/env python3

"""Example of debugging"""

__appname__ = ['Debugme example']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Silly debug example for almost Genius mathematicians
def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y - 1
            z = x / y
        except:
            print(
                f"This function did not work. Final values are { x = } and { y = }")
    return z


print("*** First Debugging example:")
buggyfunc(20)
print(" ")


# Another "clever" maths problem to DEBUG
def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y - 1
            z = x / y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work;{x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }, {z = };")
    return z


print("*** Another Debuging example:")
buggyfunc(20)
