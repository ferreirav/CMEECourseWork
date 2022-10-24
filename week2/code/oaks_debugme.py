#!/usr/bin/env python3

"""
This script looks for typo bugs in is_an_oak() function and perform doctests
Alternative typo misspelling options are given!
"""

__appname__ = ['Oaks debugme script']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'

# imports
import sys
import csv
import doctest

# Information to call the --verbose flag when running the script
print("No output???")
print("Don't forget to add the --verbose flag!!!")


# Define function
def is_an_oak(name):
    """
    Returns True if name is starts with 'quercus'

    >>> is_an_oak("querrcus")
    True

    >>> is_an_oak("querrcu")
    True

    >>> is_an_oak("qerrcus")
    True

    >>> is_an_oak("quercus ")
    True

    >>> is_an_oak("Fagus sylvatica")
    False

    >>> is_an_oak("Fagus Japonica")
    False

    """
    # A design of a very rudimentary way to test for reasonable typos that user
    # can do, alternatively regex can improve this function!!

    if name.lower().startswith('quercus'):
        return True
    if name.lower().startswith('quercus '):
        return True
    elif name.lower().startswith('querrcus'):
        return True
    elif name.lower().startswith('querrcu'):
        return True
    elif name.lower().startswith('qerrcus'):
        return True
    elif name.lower().startswith('qerrcu'):
        return True
    else:
        return False


def main(argv):
    f = open('../data/TestOaksData.csv', 'r')
    g = open('../results/JustOaksData.csv', 'w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        # print(row)
        # print("The genus is: ")
        # print(row[0] + '\n')
        if is_an_oak(row[0]):
            # print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])

    return 0


if __name__ == "__main__":
    status = main(sys.argv)

doctest.testmod()
