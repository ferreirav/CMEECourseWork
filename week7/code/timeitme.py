#!/usr/bin/env python3

"""
This script imports functions from another two scripts and run profiling tests
"""

__appname__ = ['timeitme']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


##############################################################################
# loops vs. list comprehensions: which is faster?
##############################################################################

iters = 1000000

import time

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

##############################################################################
# loops vs. the join method for strings: which is faster?
##############################################################################

mystring = "my string"

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join



##############################################################################
# QUICK PROFILING
##############################################################################

start = time.time()
my_squares_loops(iters)
print(f"my_squares_loops takes {time.time() - start} s to run.")

start = time.time()
my_squares_lc(iters)
print(f"my_squares_lc takes {time.time() - start} s to run.")


