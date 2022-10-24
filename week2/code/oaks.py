#!/usr/bin/env python3

"""An example script for extracting target string from the list"""

__appname__ = ['Oak String Extraction']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# List of species
taxa = ['Quercus robur',
        'Fraxinus excelsior',
        'Pinus sylvestris',
        'Quercus cerris',
        'Quercus petraea']


# function
def is_an_oak(name):
    return name.lower().startswith('quercus ')


# Using loop to retrieve list back
oaks_loop = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loop.add(species)
print("Conventional loop prints out:")
print(oaks_loop)
print(" ")


# Using list comprehensions to retrieve list back
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print("List comprehensions prints out:")
print(oaks_lc)
print(" ")


# Get names retrieved in UPPER CASE using loops
oaks_loop = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loop.add(species.upper())
print("Conventional loop prints out in UPPER CASE:")
print(oaks_loop)
print(" ")


# Use List Comprehensions to get the names in UPPER CASE
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print("List comprehensions prints out in UPPER CASE:")
print(oaks_lc)
print(" ")
