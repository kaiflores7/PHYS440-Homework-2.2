//
//  Bessel Function.swift
//  Homework 2.2
//
//  Created by Katia Flores on 2/4/22.
//

import Foundation
import SwiftUI


/* Calculate Bessel functions using downward recursion */
/// calculateDownwardRecursion
/// - Parameters:
///   - xValue: x
///   - order: Order of Bessel Function
///   - start: Starting Order
///              2l + 1
///     J       (x)  =   ------ J  (x)   -  J        (x)
///      l - 1              x       l             l + 1
///
///
func calculateDownwardRecursion (xValue: Double, order: Int, start: Int) -> Double
{
    var scale = calculateZeroBessel(xValue: xValue) /* jSub0 which we know. Used for scaling the downward recursion */
    
    var jSubl = Array(repeating: 0.0, count: start + 2) /* jSubl is an array that holds the various orders of the Bessel Function */
    
    
    jSubl[start+1] = 1.0                   // start with "guess"
    jSubl[start] = 1.0                      // start with "guess"
    
    for index in (1...start).reversed(){
        
        jSubl[index-1] = ((2.0*(Double(index))+1.0)/xValue)*jSubl[index] - jSubl[index+1]
    }
    
    scale = (scale)/jSubl[0];      /* scale the result */
    
    return(jSubl[order]*(scale))
}


/* Calculate Bessel functions using upward recursion */
/// calculateUpwardRecursion
/// - Parameters:
///   - xValue: x
///   - order: Order of Bessel Function
///               2l + 1
///     J          (x)  =   ------  J  (x)  -  J       (x)
///       l + 1              x        l            l - 1
///
///
func calculateUpwardRecursion (xValue: Double, order: Int) -> Double
{
    var zeroBessel = 0.0  /* temporary placeholders through the upward recursion */
    var firstBessel = 0.0 /* temporary placeholders through the upward recursion */
    var finalBessel = 0.0; /* holds final Bessel Function result */
    
    
    zeroBessel = calculateZeroBessel(xValue: xValue) /* start with lowest order */
    firstBessel = calculateFirstBessel (xValue: xValue)
    
    if (order == 0) {
        finalBessel = zeroBessel
    }
    else if (order == 1) {
        finalBessel = firstBessel
    }
    else {
        for index in (1..<order)             /* loop for order of function */
        {
            finalBessel = ((2.0*(Double(index))+1.0)/xValue)*firstBessel - zeroBessel       // recursion relation
            //update values
            zeroBessel = firstBessel
            firstBessel = finalBessel
        }
    }
    return(finalBessel)
}



/// calculateFirstBessel
/// - Parameter xValue: x
/// - Returns: first Bessel Function

func calculateZeroBessel (xValue: Double) -> Double{
    
    var j = 0.0
    
    j = sin(xValue) / xValue
    
    return j
    
}


/// calculateSecondBessel
/// - Parameter xValue: x
/// - Returns: second Bessel Function

func calculateFirstBessel (xValue: Double) -> Double{
    
    var j = 0.0
    let sinFunc = sin(xValue) / (xValue↑(2.0))
    let cosFunc = cos(xValue) / xValue
    
    j = sinFunc - cosFunc
    
    return j
    
}

