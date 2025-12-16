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

$\text{Mass Density},\rho = 7800 \space kg/m^3 = 7800 \times 10^{-9}\space kg/mm^3$

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
                            -1 & 1  
                            \end{bmatrix}
$$

$k$ for Element 1

$$
    k_1 = \frac{A_1\times E}{L_1} \times \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  
                            \end{bmatrix}
$$

$$
    k_1 = \frac{700\times 2 \times 10^5}{150} \times                   \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  
                            \end{bmatrix}
$$

$$
    k_1 = \begin{bmatrix}
           9.333 & -9.333 \\\\
           -9.333 & 9.333 
           \end{bmatrix} \times 10^5\space N/mm
$$

$k$ for Element 2

$$
    k_2 = \frac{A_2\times E}{L_2} \times \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  
                            \end{bmatrix}
$$

$$
    k_2 = \frac{500\times 2 \times 10^5}{150} \times                   \begin{bmatrix}
                            1 & -1  \\\\
                            -1 & 1  
                            \end{bmatrix}
$$

$$
    k_2 = \begin{bmatrix}
           6.667 & -6.667 \\\\
           -6.667 &  6.667 
           \end{bmatrix} \times 10^5\space N/mm
$$

The next step  is to find the assembled stiffness matrix $K$

To find $K$ we need to mark the elements of $k_1$ and $k_2$ according to the nodes which form the respective elements.

- Consider the element 1, it is formed by nodes 1 and 2. So the elements in $k_1$ matrix is marked as follows:

    - $$

            \begin{bmatrix}
           9.333 & -9.333 \\\\
           -9.333 & 9.333 
           \end{bmatrix} \times 10^5 =

            \begin{bmatrix}
                (1,1)&(1,2) \\\\
                (2,1)&(2,2) 
            \end{bmatrix}
      $$

    - These markings correspond to the position of elements in the assembled stiffness matrix $K$

- Next considering the element 2, it is formed by nodes 2 and 3. So the elements in $k_2$ matrix is marked as follows:
    - $$

            \begin{bmatrix}
           6.667 & -6.667 \\\\
           -6.667 &  6.667 
           \end{bmatrix} \times 10^5 =

            \begin{bmatrix}
                (2,2)&(2,3) \\\\
                (3,2)&(3,3) \\\\
            \end{bmatrix}
      $$

    - These markings correspond to the position of elements in the assembled stiffness matrix $K$

The assembled stiffness matrix is calculated by placing the above elements in their respective positions.

$$
 K = \begin{bmatrix}
        9.333 & -9.333 & 0 \\\\
        -9.333 & 9.333 + 6.667 & -6.667 \\\\
        0 & -6.667 & 6.667 
     \end{bmatrix} \times 10^5 \space N/mm
$$

$$
 K = \begin{bmatrix}
        9.333 & -9.333 & 0 \\\\
        -9.333 & 16 & -6.667 \\\\
        0 & -6.667 & 6.667 
     \end{bmatrix} \times 10^5 \space N/mm
$$

### Calculating Forces at each nodes
Now We need to calculate the forces acting at each node

For that we need to find the body weight of each element.

So, The body weight of element 1

$$
    W_1 = A_1L_1\rho g
$$

$$
    W_1 = 700\times 150 \times 7800 \times 10^{-9} \times 9.81
$$

$$
    W_1 = 8.03439\space N
$$

The body weight of element 2

$$
    W_2 = A_2L_2\rho g
$$

$$
    W_2 = 500\times 150 \times 7800 \times 10^{-9} \times 9.81
$$

$$
    W_2 =  5.73885\space N
$$

Now We can use $W_1$ and $W_2$ to calculate the force at each nodes ($F_1, F_2, F_3$)

$$
    F_1 = \frac{\text{Body weight of element 1}}{2} = \frac{8.03409}{2} = 4.017195\space N
$$

$$
    F_2 = \frac{\text{Body weight of element 1 + Body weight of element 2}}{2} = \frac{8.03409 + 5.73885}{2} =6.88662\space N
$$

$$
    F_3 = \frac{\text{Body weight of element 2}}{2} = \frac{5.73885}{2} = 2.869425\space N
$$


