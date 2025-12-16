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

### Given

$E = 2 \times 10^5$ $MN/m^2$  = $2 \times 10^5$ $N/mm^2$

$\text{Total Length} = 300\space mm$

$\text{Mass Density},\rho = 7800 \space kg/m^3 = 7800 \times 10^{-9}\space kg/mm^3$

In this problem we assume **downward forces as positive**

So to form two elements we need to take three nodes.

### Calculating Area at each node
width at node 1 = 80 mm 
thickness = 10 mm 

Area at node 1 = width at node 1 $\times$ thickness = 80 $\times$ 10 = 800 $mm^2$

Area at node 3 = width at node 3 $\times$ thickness  = 40 $\times$ 10 = 400 $mm^2$

Area at node 2 = $\frac{\text{Area at node 1 + Area at node 3}}{2}$ = $\frac{800+400}{2}$ = 600  $mm^2$

Using the areas at each node we can calculate the cross section area of each element

### Calculating Area at each element

The area of cross section for Element 1

$$
    A_1 = \frac{\text{Area at node 1 + Area at node 2}}{2} = \frac{800+600}{2} = 700 \space mm^2
$$

Similarly, The area of cross section for Element 2

$$
    A_2 = \frac{\text{Area at node 2 + Area at node 3}}{2} = \frac{600+400}{2} = 500 \space mm^2
$$

### Calculating local stiffness matrix $k$
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

### Calculating the Assembled Stiffness Matrix $K$
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

### Calculating displacements at each node
Analysing the given structure, we can see that one end is fixed which will not undergo any displacement. Node 1 is the node which represents the fixed end. So the displacement at node 1, $q1$ is zero. 

The above condition reduces the assembled stiffness matrix K.

$$
 K_{reduced} = \begin{bmatrix}
       
         16 & -6.667 \\\\
         -6.667 & 6.667 
     \end{bmatrix} \times 10^5 \space N/mm
$$

To find the displacement at each node,

$$
    [F] = [K][q]
$$

Here
- $[F]$ represents the force at each node
-  $[K]$ represents the  assembled stiffness matrix
- $[q]$ represents the dispacements at each node

$$
    \begin{bmatrix}
    F_1 \\\\
    F_2 \\\\
    F_3 
    \end{bmatrix} 
    = 
    [K]
    \begin{bmatrix}
    q_1 \\\\
    q_2 \\\\
    q_3 
    \end{bmatrix} 
$$

As discussed earlier $q1$ is 0 so the above equation reduces to

$$
    \begin{bmatrix}
    F_2 \\\\
    F_3 
    \end{bmatrix} 
    = 
    [K_{reduced}]
    \begin{bmatrix}
    q_2 \\\\
    q_3 
    \end{bmatrix} 
$$

$$
    
    \begin{bmatrix}
    6.88662 \\\\
    2.869425
    \end{bmatrix} 
    = 
    \begin{bmatrix}
      16 & -6.667 \\\\
     -6.667 & 6.667 
     \end{bmatrix} \times 10^5
    \times
    \begin{bmatrix}
    q_2 \\\\
    q_3 
    \end{bmatrix} 
$$

$$
    \begin{bmatrix}
    q_2 \\\\
    q_3 
    \end{bmatrix}
    = 
    \begin{bmatrix}
     16 & -6.667 \\\\
    -6.667 & 6.667 
     \end{bmatrix}^{-1} \times 10^{-5}
    \times
    
    \begin{bmatrix}
    6.88662 \\\\
    2.869425
    \end{bmatrix} 
$$

$$
    \begin{bmatrix}
    q_2 \\\\
    q_3 
    \end{bmatrix}
    =
    \begin{bmatrix}
    0.1045327 \\\\
    0.1475720 
    \end{bmatrix} \times 10^{-4} \space mm 
$$

## MATLAB Code

The problem solely depends on the number of elements, the structure is being discritized.
### Setup and Input
```matlab
format long
num_elements = 2;
non = num_elements + 1;
```
In the above code we define the number of elements and using the number of elements, we calculate the number of nodes.

The line 'format long' changes the default display format from short to long. The long format displays 15 digits after the decimal point for double values and 7 digits for single values.
### Given parameters
```matlab
thickness = 0.01; % m (constant)
width_start = 0.08; % m (width at node 1)
width_end = 0.04; % m (width at node non)
E = 2e11; % Pa
total_length = 0.3; % m
lengths = (total_length/(non-1))*ones(1, non-1); % m (array of element lengths)
rho = 7800; % kg/m^3
g = 9.81; % m/s^2
```

Defining the given parameters in SI units.


'lengths' is an array containing lengths of each element after discritization of the structure.

### Calculating the Area of each element
```matlab
% widths at all nodes (linear taper)
widths_nodes = linspace(width_start, width_end, non);

% Areas at nodes
areas_nodes = widths_nodes * thickness;

% Areas for elements (average of adjacent nodes)

area_elements = zeros(1, num_elements);
for e = 1:num_elements
    area_elements(e) = (areas_nodes(e) + areas_nodes(e+1)) / 2;
end
```
The above code block interpolates the widths at each node. As the top width and bottom width of the taper bar are given. We can use linspace() function to split them into linearly spaced elements using the num_elements variable. 

Calculating the areas at each node and using them to calculate the area of each element.
We declared a row vector named area_elements using zeros() function using num_elements. So here as num_elements = 2, area_elements = [0 0]. 

The for loop part calculates the area of each element as already seen in the theory part. The area of element 1 is equal to area of node 1 + area of node 2 divided by 2. Same for element 2 - area of node 2 + area of node 3 divided by 2. So by observin the pattern we can write the above code.

### Calculating the Assembled Stiffness Matrix K
```matlab
% Element stiffnesses
k = (area_elements .* E) ./ lengths;

% Assembled Stiffness Matrix
K = zeros(non);
for e = 1:num_elements
    K(e:e+1, e:e+1) = K(e:e+1, e:e+1) + k(e) * [1 -1; -1 1];
end
```
The above code block calculates the Assembled stiffness matrix.
Let us take this case and go through the loop. (num_elements = 2)

We first calculate the value of stiffness for each matrix and then multiply with the [1 -1; -1 1] matrix to get the local stiffness matrix.

We initialize the assembled stiffnes matrix K using the zeros() function. Here non = 3, so we get a 3x3 matrix filled with zeros.

Going though the loop, if e = 1 K(1:2, 1:2) = K(1:2, 1:2) + k(1)*[1 -1; -1 1], so the calculated value of stiffness is used here and it is added with the corresponding position in the K matrix.

Similarly if e = 2, we get K(2:3, 2:3) = K(2:3,2:3) + k(2)*[1 -1; -1 1]. 

This code replicates the theory we have studied before. After completion of the loop we get the assembled stiffness matrix K.

### Calculating Forces at each node
```matlab
% Element weights
W = area_elements .* lengths * rho * g;

%Forces at each due to self-weight
F = zeros(non, 1);
for e = 1:num_elements
    F(e) = F(e) + W(e) / 2;
    F(e+1) = F(e+1) + W(e) / 2;
end
```
The above code block calculates forces at each nodes by calculating the weight of each elements. The formula used for calculating W is already shown in the theory part.

There are three nodes in this example so there will be three forces. As earlier we initialize a column vector named F using the zeros() function.
The force in first node and the last node is solely due to the first and last element. The intermediate nodes experience a force due to the element above and below it (as already seen in the theory)

Going through the loop (num_elements = 2)
- if e = 1, F(1) = F(1) + W(1)/2 and F(2) = F(2) + W(1)/2 
- if e = 2, F(2) = F(2) + W(2)/2 and F(3) = F(3) + W(2)/2 

From observing this, we can see that the second line in first iteration adds the value of weight contribution of the top element to node 2, similarly the first line in the second iteration adds the value of weight contribution of the bottom element to node 2. 

## Calculating the displacements at each node

```matlab
% Boundary condition: node 1 fixed (q1 = 0)
K_reduced = K(2:end, 2:end);
F_reduced = F(2:end);
q_reduced = K_reduced \ F_reduced;

% Full displacements (q1 = 0)
q = zeros(non, 1);
q(2:end) = q_reduced;

% Results: Displacements at nodes 2 to non (in mm, downward positive)
disp("Results: Displacements at nodes 2 to end (mm)");
for i = 2:non
    fprintf("q%d = %.7f mm\n", i, q(i) * 1e3);
end
```
As seen in the theory part, there will be no dispacement at node 1, so the assembled stiffness matrix reduces from 3x3 to a 2x2 matrix, where the first row and column are removed.

Using the formula we saw in the theory part we calculate the displacements and the displacements are stored in a column vector named q.

Finally we print the displacement at each nodes.
