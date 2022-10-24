#!/usr/bin/env python3

"""Transforms a list of tuples into an organised dictionary of taxa"""

__appname__ = ['Dictionary Exercise']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'

# imports
from pprint import pprint

# Data provided
taxa = [('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Creating Dictionary
taxa_dic = {}
for t in taxa:
        if t[1] in taxa_dic:
                taxa_dic[t[1]].add(t[0])
        else:
                taxa_dic[t[1]] = [t[0]]
                taxa_dic[t[1]] = set(taxa_dic[t[1]])  # converts the key in a
#                                                   set without any duplicates


# ============== PRINTS===========
# Prettier prints
print("The final dictionary with the populated taxa is:")
pprint(taxa_dic)
