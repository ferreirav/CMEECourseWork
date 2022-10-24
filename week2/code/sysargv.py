#!/usr/bin/env python3

"""This script spits out the argument details provided"""

__appname__ = ['boilerplate template']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Imports
import sys

print("The name of this script it is: ", sys.argv[0])
print("The number of arguments are: ", len(sys.argv))
print("The arguments are: ", str(sys.argv))
