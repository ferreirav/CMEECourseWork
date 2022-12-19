#!/usr/bin/env python3

"""
This script runs Lotka-Volterra model and plots the relationship between Consumer and Resource.
"""

__appname__ = ['Lotka-Volterra Model 1']
__author__ = 'Vitor Ferreira (f.ferreira22@imperial.ac.uk)'


# Practical on the Lotka-Volterra model
# Imports
import sys
import scipy as sc
import scipy.integrate as integrate
import numpy as np
import matplotlib.pylab as p


# Constants
r = 1.
a = 0.1
z = 1.5
e = 0.75

# Time vector 
t = np.linspace(0, 15, 1000)

# Initial conditions for the two populations
R0 = 10
C0 = 5
RC0 = np.array([R0, C0])

# FUNCTIONS
def dCR_dt(pops, t = 0):
    """Function to calculate growth rate of consumer and resource"""
    
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a*R*C
    dCdt = -z * C + e*a*R*C
    
    return np.array([dRdt, dCdt])


def main(argv):
    """Main function call"""
    # Numerically integration of this system with the starting conditions
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    ###########################
    #####    Plotting    ######

    f1 = p.figure()  # Opening an empty object
    p.plot(t, pops[:, 0], "g-", label = "Resource density")
    p.plot(t, pops[:, 1], "b-", label = "Consumer density")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Time")
    p.ylabel("Population density")
    p.title("Consumer-Resource population dynamics")
    f1.savefig("../results/LV_model.pdf")



    ###########################
    #####    Plotting    ######


    f1 = p.figure()  # Opening an empty object
    p.plot(pops[:, 0], pops[:, 1], "r-", label = "Consumer density")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")
    f1.savefig("../results/LV_loopy_model.pdf")

    print("Lotka-Volterra model is plotted and can be found in Results folder!!!")
    
    
if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)

