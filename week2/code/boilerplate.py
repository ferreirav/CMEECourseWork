#!/usr/bin/env python3

"""Description..."""

__appname__ = ['boilerplate template']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'Currently without license'


# imports
import sys  # This is a module that interfaces with the operating system

# constants

# functions


def main(argv):
    """Main entry point of the program"""
    print("This is a boilerplate")
    return 0  # Only setting "zero" will not give any error


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
