#!/usr/bin/env python3

"""List Comprehensions exercise - From tuples to Lists"""

__appname__ = ['List Comprehensions Exercise']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Data from http://www.metoffice.gov.uk/climate/uk/datasets


# Average UK Rainfall (mm) for 1910 by month
rainfall = (('JAN', 111.4),
            ('FEB', 126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG', 140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV', 128.4),
            ('DEC', 142.2),
            )

# (1) List comprehension for rainy months
rainy_months_lc = [r for r in rainfall if r[1] > 100]

# (2)List comprehension for dry months
dry_months_lc = [r for r in rainfall if r[1] < 50]

print("Using list comprehension we obtained following results:")
print("The months with more rain and its respective amount of rain (mm) were:", rainy_months_lc)
print("The drier months were (rain in mm):", dry_months_lc)
print(" ")

# (3) Using conventional loops to identify drier and rainy months
loop_rainy_months = []
loop_dry_months = []

for r in rainfall:
    if r[1] > 100:
        loop_rainy_months.append(r)
    elif r[1] < 50:
        loop_dry_months.append(r)

print("The same results were given when using conventional loops:")
print("The months with more rain and its respective amount of rain (mm) were:", loop_rainy_months)
print("The drier months were (rain in mm):", loop_dry_months)
print(" ")
print("Complete!!!")
