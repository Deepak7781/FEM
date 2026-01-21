% A vertical elastic bar of length L is suspended from the top and free at
% the bottom. The bar has a linearly varying cross sectional area and is
% subjected only to its own weight.

% Given Data
% Length L = 2 m
% Youmg's Modulus = 200 x 10^9 Pa
% Density = 7850 kg/m^3
% Gravity g = 9.81 m/s^2
% Area at top A0 = 600 mm^2
% Area at bottom A1 = 200 mm^2


% L = input('Enter the length of the bar in m:'); % Length in meters
% E = input("Enter the Young's Modulus of the material in Pa:"); % Young's Modulus in Pa
% rho = input("Enter the density of the material in kg/m3:"); % Density in kg/m^3
% g = 9.81; % Gravity in m/s^2
% A0 = input('Enter area at the top in m^2:'); % Area at top in m^2
% A1 = input('Enter area at the bottom in m^2:'); % Area at bottom in m^2

L = 2; % Length in meters
E = 200e9; % Young's Modulus in Pa
rho = 7850; % Density in kg/m^3
g = 9.81; % Gravity in m/s^2
A0 = 600e-6; % Area at top in m^2
A1 = 200e-6; % Area at bottom in m^2

N = input('Enter the number of Elements:');
non = N + 1;
lengths = L/N*ones(1, N);
areas_nodes = linspace(A0, A1, non);

areas_elements = zeros(1,N);

for i = 1:N
    areas_elements(i) = (areas_nodes(i) + areas_nodes(i+1))/2;
end    

% Element stiffnesses

k = (areas_elements.*E)./lengths;

% Calculate the global stiffness matrix
K = zeros(non);

for i = 1:N
    K(i:i+1,i:i+1) = K(i:i+1, i:i+1) + k(i)*[1 -1; -1 1];
end
    
% Elemental Weights
W = areas_elements.*lengths*rho*g;

% Force at each node 

F = zeros(non, 1);

for i = 1:N
    F(i) = F(i) + W(i)/2;
    F(i+1) = F(i+1) + W(i)/2;
end


% Calculate displacements at each node

% The displacement at node 1 is zero

K_reduced = K(2:end, 2:end);

U_reduced = K_reduced\F(2:end);

U = [0 ;U_reduced];


strain = zeros(N,1);
stress = zeros(N,1);

for i = 1:N
    strain(i) = (U(i+1) - U(i)) / lengths(i);   % Strain
    stress(i) = E * strain(i);                  % Stress
end

disp("Results: Displacements at nodes 1 to end (mm)");
for i = 1:non
    fprintf("q%d = %.7f mm\n", i, U(i) * 1e3);
end

disp("Results: Stresses and Strains at elements 1 to end");
for i = 1:N
    fprintf("Element %d: Strain = %.9f, Stress = %.7f Pa\n", i, strain(i), stress(i));
end
