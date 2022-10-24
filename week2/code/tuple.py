#!/usr/bin/env python3

"""This script will print out a tidy description of birds species"""

__appname__ = ['Tuple Exercise']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Data
birds = (('Passerculus sandwichensis', 'Savannah sparrow', 18.7),
          ('Delichon urbica', 'House martin', 19),
          ('Junco phaeonotus', 'Yellow-eyed junco', 19.5),
          ('Junco hyemalis', 'Dark-eyed junco', 19.6),
          ('Tachycineata bicolor', 'Tree swallow', 20.2),
         )


# Using conventional FOR loops
print("The birds species extracted from the tuple are:")
for b in birds:
    print("")
    print(f"Latin name: {b[0]}")
    print(f"Common name: {b[1]}")
    print(f"Body Mass: {b[2]}")
    print("============================")
