#!/usr/bin/env python
"""
DESCRIPTION

    Prints the polynomials that describe a photoshop curve.
    There are three curves (one per RGB channel) which you can later 
    use to make a custom filter for your image.
    
    See www.linktotumblrpost.com for the theory behind this method.

USAGE

    python extractCurvesFromACVFile.py theCurveFile.acv

AUTHOR

    email: vassilis@weemoapps.com
    twitter: @weemoapps

LICENSE

    This script is in the public domain, free from copyrights or restrictions.

VERSION

    0.1
"""

import sys, os, traceback, optparse, time
from struct import unpack
from scipy import interpolate
import pylab
import numpy as np
        
def read_curve(acv_file):
    curve = []
    number_of_points_in_curve, = unpack("!h", acv_file.read(2))
    for j in range(number_of_points_in_curve):
        y, x = unpack("!hh", acv_file.read(4))
        curve.append((x, y))
    return curve
    
def return_polynomial_coefficients(curve_list):
	xdata = [x[0] for x in curve_list]
	ydata = [x[1] for x in curve_list]
	np.set_printoptions(precision=6)
	np.set_printoptions(suppress=True)
	p = interpolate.lagrange(xdata, ydata)
	return p
	#coefficients = p.c
	#print coefficients

def main ():
	acv_file = open('Country.acv', "rb")
	_, nr_curves = unpack("!hh", acv_file.read(4))
	curves = []
	for i in range(nr_curves):
		curves.append(read_curve(acv_file))
	compositeCurve = curves[0]
	redCurve = curves[1]
	greenCurve = curves[2]
	blueCurve = curves[3]
	
	print "************* Red Curve *************"
	pRed = return_polynomial_coefficients(redCurve)
	print pRed
	print "*************************************\n"

	print "************* Green Curve *************"
	pGreen = return_polynomial_coefficients(greenCurve)
	print pGreen
	print "*************************************\n"

	print "************* Blue Curve *************"
	pBlue = return_polynomial_coefficients(blueCurve)
	print pBlue
	print "*************************************\n"
	


if __name__ == '__main__':
   try:
        main()
   except Exception, e:
        print 'ERROR, UNEXPECTED EXCEPTION'
        print str(e)
        traceback.print_exc()
        os._exit(1)