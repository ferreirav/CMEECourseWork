#!/usr/bin/env python3

"""Importing and exporting files in Python"""

__appname__ = ['Basic I/O in Python']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


##################################
# FILE INPUT - OPEN / CLOSE METHOD
##################################
# Open a file for reading
f = open('../data/test.csv', 'r')

# use "implicit" for loop:
# if the object is a file, python will cycle over the lines
for line in f:
    print(line)

f.close


# Following the same example but stripping blank lines
f = open('../data/test.csv', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close


#############################################
# FRIENDLY AND SECURE WAY TO RUN FILE INPUT #
#############################################


#############################
# FILE INPUT
#############################
# Open a file
with open('../data/test.csv', 'r') as f:
    for line in f:
        print(line)
# Loop will automatically close the file

# Same example, stripping blank lines
with open('../data/test.csv', 'r') as f:
    for line in f:
        if len(line.strip()) > 0:
            print(line)




