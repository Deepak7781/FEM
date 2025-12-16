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

Given:

$E = 2 \times 10^5$ $MN/m^2$  = $2 \times 10^5$ $N/mm^2$

$\text{Total Length} = 300\space mm$


So to form two elements we need to take three nodes.


width at node 1 = 80 mm 
thickness = 10 mm 

Area at node 1 = width at node 1 $\times$ thickness = 80 $\times$ 10 = 800 $mm^2$

Area at node 3 = width at node 3 $\times$ thickness  = 40 $\times$ 10 = 400 $mm^2$

Area at node 2 = $\frac{\text{Area at node 1 + Area at node 3}}{2}$ = $\frac{800+400}{2}$ = 600  $mm^2$

Using the areas at each node we can calculate the cross section area of each element

The area of cross section for Element 1

$$
    A_1 = \frac{\text{Area at node 1 + Area at node 2}}{2} = \frac{800+600}{2} = 700 \space mm^2
$$

Similarly, The area of cross section for Element 2

$$
    A_2 = \frac{\text{Area at node 2 + Area at node 3}}{2} = \frac{600+400}{2} = 500 \space mm^2
$$

Next step is to find the local stifness matrix $k$

$$
    k = \frac{AE}{L} \times \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  \\\\
                            \end{bmatrix}
$$

$k$ for Element 1

$$
    k_1 = \frac{A_1\times E}{L_1} \times \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  \\\\
                            \end{bmatrix}
$$

$$
    k_1 = \frac{700\times 2 \times 10^5}{150} \times                   \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  \\\\
                            \end{bmatrix}
$$

$$
    k_1 = \begin{bmatrix}
           9.333 & -9.333 \\\\
           -9.333 & 9.333 \\\\
           \end{bmatrix} \times 10^5\space N/mm
$$

$k$ for Element 2

$$
    k_2 = \frac{A_2\times E}{L_2} \times \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  \\\\
                            \end{bmatrix}
$$

$$
    k_2 = \frac{500\times 2 \times 10^5}{150} \times                   \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  \\\\
                            \end{bmatrix}
$$

$$
    k_2 = \begin{bmatrix}
           6.667 & -6.667 \\\\
           -6.667 &  6.667 \\\\
           \end{bmatrix} \times 10^5\space N/mm
$$

