#!/usr/bin/env python3

""" This script contains functions to test profiling """

__appname__ = ['profileme']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'

# Functions
def my_squares(iters):
    """Append to the string"""
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """Append to the string"""
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """Concatenation of the two given vectors"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")