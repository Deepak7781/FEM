# Tapered Bar - Only self weight

## Problem

For a tapered bar of uniform thickness t = 10 mm as shown in figure. Find the displacement at the nodes by forming 

- 5 elements
- 10 elements
- 15 elements
- 20 elements

The bar has mass density $\rho=7800$ $kg/m^3$. Young's Modulus E = $2\times10^5 MN/m^2$. The bar is subjected to no other external force except its self weight.

## Solution

Let us first solve this problem by forming only 2 elements and let us build a Matlab program for large number of elements.

So to form two elements we need to take three nodes.


width at node 1 = 80 mm 
thickness = 10 mm 

Area at node 1 = width at node 1 $\times$ thickness = 80 $\times$ 10 = 800 $mm^2$

Area at node 2 = width at node 2 $\times$ thickness  = 80 $\times$ 10 = 800 $mm^2$