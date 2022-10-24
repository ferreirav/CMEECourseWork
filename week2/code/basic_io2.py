#!/usr/bin/env python3

"""Importing and exporting files in Python."""

__appname__ = ['Basic I/O in Python']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'

######################
# FILE INPUT
######################

# Create a list with values
list_to_save = range(100)

f = open('../results/testout.txt', 'w')
for i in list_to_save:
    f.write(str(i) + '\n')  # Creates file to store the results

f.close()  # and closes the file once completed the operation
