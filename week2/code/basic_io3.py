#!/usr/bin/env python3

"""Importing and exporting files in Python."""

__appname__ = ['Basic I/O in Python']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# imports
import pickle  # This module creates portable serialized reps of python objects

########################
# Storing Objects
########################

my_dictionary = {"a key": 10, "another key": 11}


f = open('../results/testp.p', 'wb')  # This notation tells python to
                                      # write binary "wb" file
pickle.dump(my_dictionary, f)
f.close()

# Loading data again
f = open('../results/testp.p', 'rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)
