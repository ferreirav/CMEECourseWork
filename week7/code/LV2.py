#!/usr/bin/env python3

"""
This script runs Lotka-Volterra model and plots the relationship between Consumer and Resource

Arguments can be provided for model simulations entering parameters following parameters:

r = growth rate; a = search rate; z = mortality rate; e = assimilation efficiency; K = carrying capacity

"""

__appname__ = ['Lotka-Volterra Model 2']
__author__ = 'Vitor Ferreira (f.ferreira2@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'Currently without license'


# Practical on the Lotka-Volterra model
# Imports

import sys

import matplotlib.pylab as p
import numpy as np
import scipy as sc
import scipy.integrate as integrate


# Functions
def dCR_dt(pops, t=0, r=0, a=0, z=0, e=0, K=0):
    """Function to calculate growth rate of consumer and resource"""
    
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - R/K) - a*R*C
    dCdt = -z * C + e*a*R*C  # type: ignore
    
    return np.array([dRdt, dCdt])


def main(argv):
    """Calculates predator-prey/consumer-resource dynamics using Lotka-Volterra model

    Args:
        r = growth rate;
        a = search rate;
        z = mortality rate;
        e = assimilation efficiency;
        K = carrying capacity
    """
    
    # Assigning values to variables
    if len(sys.argv) == 6:
        r = np.float64(sys.argv[1])
        a = np.float64(sys.argv[2])
        z = np.float64(sys.argv[3])
        e = np.float64(sys.argv[4])
        K = np.float64(sys.argv[5])
    else:
        r = 1.
        a = 0.3
        z = 1.4
        e = 0.9
        K = 75

        
    # Creating time vector 
    t = np.linspace(0, 200, 1000)

    # Setting the initial conditions for the two populations
    R0 = 10
    C0 = 5
    RC0 = np.array([R0, C0])

    # Now numerically integrate this system with those stating conditions

    pops, infodict = integrate.odeint(dCR_dt, RC0, t, args=(r, a, z, e, K), 
                                      full_output=True)

    type(infodict)
    infodict.keys()
    infodict['message']

    print(f"The Prey densities at the end of simulations it is {pops[-1][0]}")
    print(f"The Predator densities at the end of simulations it is {pops[-1][1]}")


    #########################################################
    #####    Plotting Model with dynamics over time    ######


    f1 = p.figure()  # Opening an empty object
    p.plot(t, pops[:, 0], "g-", label = "Resource density")
    p.plot(t, pops[:, 1], "b-", label = "Consumer density")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Time")
    p.ylabel("Population density")
    p.title("Consumer-Resource population dynamics")
    p.text(150, 8, f"r = {r}\na = {a}\nz = {z}\ne = {e}\nK = {K}")
    f1.savefig("../results/LV2_model.pdf")



    ####################################################################
    #####    Plotting Consumer-Resource/Predator-Prey Dynamics    ######


    f1 = p.figure()  # Opening an empty object
    p.plot(pops[:, 0], pops[:, 1], "r-", label = "Consumer density")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")
    f1.savefig("../results/LV2_CR_model.pdf")


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
