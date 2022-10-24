#!/usr/bin/env python3

"""This script will run over some examples of Python loops"""

__appname__ = ['Loops and While Loops']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# FOR loops examples:
print("Running Loops script!")
for i in range(5):
    print(i)

# Looping over a list
my_list = [0, 2, "Vitorinooooo!", 3.0, True, False]
for k in my_list:
    print(k)

# Looping over variables
total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)

# WHILE loops
z = 0
while z < 100:
    z = z + 1
    print(z)

print(" ")
print("Running Loops Completed!!!!")
