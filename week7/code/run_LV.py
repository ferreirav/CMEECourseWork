#!/usr/bin/env python3

"""
This script calls the Lotka-Voltera scripts for profiling
"""

__appname__ = ['LVspeed']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Imports
import cProfile
from pstats import Stats

# Load scripts
import LV1
import LV2

# Profiling
for i in LV1, LV2:
    pr = cProfile.Profile()
    pr.enable()
    i.main([])
    pr.disable()

    stats = Stats(pr)
    print("Execution times for ", i, " it is:")
    stats.sort_stats("cumtime").print_stats(0)

