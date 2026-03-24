% A uniform bar of length 2 m, Area 1 m2, E = 200 GPa. An axial distributed load q = 1000 N/m acts
% along the bar. The left end is fixed. Using N elements,
% find the Nodal displacements and stresses

L = 2; % Length of the bar in meters
A = 1; % Cross-sectional area in square meters
E = 200e9; % Young's modulus in Pascals
N = 2; % Number of elements
q = 1000; % Axial load in N/m

Le = L/N;

% Element Stiffness Matrix
ke = A*E/Le;

% Element load vector
Fe = (q*Le/2)*[1;1];

K = zeros(N+1); % Global stiffness matrix
F = zeros(N+1, 1); % Global force vector

for i = 1:N
    K(i:i+1, i:i+1) = K(i:i+1, i:i+1) + ke*[1 -1; -1 1];
    F(i:i+1) = F(i:i+1) + Fe(i); 
end

% Apply Boundary condition
u1 = 0;

U_reduced = K(2:end, 2:end)\F(2:end);

U = [u1;U_reduced];

% Calculate the stresses in each element
stress = zeros(N, 1);
for i = 1:N
    stress(i) = (U(i+1) - U(i)) * (E / Le);
end

% Display the nodal displacements and stresses
disp('Nodal Displacements (m):');
disp(U);
disp('Element Stresses (Pa):');
disp(stress);





