#!/usr/bin/env python3

""" Handling CSVs """

__appname__ = ['boilerplate template']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'

# imports
import csv

# Read in file and stores it in another variable
with open('../data/testcsv.csv', 'r') as f:

    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print("The species is", row[0])
    print(" ")


# Read in the file and writes it in new file
with open('../data/testcsv.csv', 'r') as f:
    with open('../results/bodymass.csv', 'w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        print("Saving output into results!!!")
        for row in csvread:
            csvwrite.writerow([row[0], row[4]])
        print(".")
        print(".")
        print(".")
        print("Done!!!")
