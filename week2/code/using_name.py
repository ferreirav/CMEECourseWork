#!/usr/bin/env python3

"""This script makes use of __name__ in and out python environment"""

__appname__ = ['Using Names']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Example of running script in or out python environment
if __name__ == '__main__':
    print('This program is being run by itself!')
else:
    print('I am being imported from modules!')

print("This module's name is: " + __name__)
