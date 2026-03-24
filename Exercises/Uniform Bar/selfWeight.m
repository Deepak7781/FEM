% A uniform vertical bar of length 2 m, Area 1 m^2, E = 200 GPa.
% The bar is subjected to self-weight only.
% Using N elements, find nodal displacements and stresses.

L = 2; % Length of the bar in meters
A = 1; % Cross-sectional area in m^2
E = 200e9; % Young's modulus in Pascals
N = 2; % Number of elements
rho = 1000; % Density in kg/m^3
g = 9.81; % Acceleration due to gravity (m/s^2)

Le = L/N; % Element length

% Self-weight per unit length
q = rho * A * g; % N/m

% Element Stiffness Matrix (scalar multiplier)
ke = A * E / Le;

% Element Load Vector (same as distributed load)
Fe = (q * Le / 2) * [1; 1];

K = zeros(N+1); % Global stiffness matrix
F = zeros(N+1, 1); % Global force vector

% Assembly process
for i = 1:N
    K(i:i+1, i:i+1) = K(i:i+1, i:i+1) + ke * [1 -1; -1 1];
   
    F(i:i+1) = F(i:i+1) + Fe;
end

% Apply Boundary Condition (top node fixed)
u1 = 0;

% Solve reduced system
U_reduced = K(2:end, 2:end) \ F(2:end);

U = [u1; U_reduced];

% Calculate stresses in each element
stress = zeros(N, 1);
for i = 1:N
    stress(i) = (U(i+1) - U(i)) * (E / Le);
end

% Display results
disp('Nodal Displacements (m):');
disp(U);

disp('Element Stresses (Pa):');
disp(stress);