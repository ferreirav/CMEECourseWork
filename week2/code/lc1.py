#!/usr/bin/env python3

"""List Comprehensions exercise - From tuples to Lists"""

__appname__ = ['List Comprehensions Exercise']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'

# Data
birds = (('Passerculus sandwichensis', 'Savannah sparrow', 18.7),
         ('Delichon urbica', 'House martin', 19),
         ('Junco phaeonotus', 'Yellow-eyed junco', 19.5),
         ('Junco hyemalis', 'Dark-eyed junco', 19.6),
         ('Tachycineata bicolor', 'Tree swallow', 20.2),
         )

# (1) Using list comprehensions

latin_names = [x[0] for x in birds]
common_names = [x[1] for x in birds]
body_masses = [x[2] for x in birds]

print("*** The list comprehension results are:")
print("Latin names - ", latin_names)
print("Common names - ", common_names)
print("Body masses - ", body_masses)
print(" ")
print(" ")

# (2) Using conventional loops
# Creating empty lists to store the values
loop_latin_names = []
loop_common_names = []
loop_body_masses = []

for b in birds:
    loop_latin_names.append(b[0])
    loop_common_names.append(b[1])
    loop_body_masses.append(b[2])

print("*** The conventional loop results are:")
print("Latin names - ", loop_latin_names)
print("Common names - ", loop_common_names)
print("Body masses - ", loop_body_masses)
