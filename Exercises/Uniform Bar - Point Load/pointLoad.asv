% A uniform bar of length 2 m, Area 1 m2, E = 200 GPa. A point load P acts
% at the right end of the bar. The left end is fixed. Using N elements,
% find the Nodal displacements and stresses

L = 2; % Length of the bar in meters
A = 1; % Cross-sectional area in square meters
E = 200e9; % Young's modulus in Pascals
N = 2; % Number of elements
P = 1000; % Point load in Newtons


Le = L/N;

k = A*E/Le;

% Initialize global stiffness matrix and force vector
K = zeros(N+1); % Global stiffness matrix
F = zeros(N+1, 1); % Global force vector

for i = 1:N
    K(i:i+1, i:i+1) = K(i:i+1, i:i+1) + k*[1 -1; -1 1];
end

% Apply the point load at the last node
F(end) = P;


% Apply Boundary Condition
u1 = 0;

% Initialize the displacement vector
u = zeros(N+1, 1);
u(1) = u1; 

% The reduced set of equations
u(2:end) = K(2:end, 2:end) \ F(2:end);

% Calculate the stresses in each element
stress = zeros(N, 1);
for i = 1:N
    stress(i) = (u(i+1) - u(i)) * (E / Le);
end

% Display the nodal displacements and stresses
disp('Nodal Displacements (m):');
disp(u);
disp('Element Stresses (Pa):');
disp(stress);

% Calculate the total deformation of the bar
totalDeformation = u(end);
disp('Total Deformation (m):');
disp(totalDeformation);