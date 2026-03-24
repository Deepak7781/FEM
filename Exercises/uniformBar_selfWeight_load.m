clc; clear;

% ------------------------
% INPUT PARAMETERS
% ------------------------
L = 3;              % Length (m)
A = 0.01;           % Area (m^2)
E = 200e9;          % Young's modulus (Pa)
rho = 7800;         % Density (kg/m^3)
g = 9.81;           % Gravity (m/s^2)
P = 50000;          % Point load (N)

N = input('Enter number of elements: ');

% ------------------------
% DISCRETIZATION
% ------------------------
nn = N + 1;                 % number of nodes
Le = L/N;

K = zeros(nn);
F = zeros(nn,1);

% ------------------------
% ASSEMBLY
% ------------------------
for e = 1:N
    
    ke = (A*E/Le)*[1 -1; -1 1];
    
    fe = (rho*A*g*Le/2)*[1;1];
    
    K(e:e+1, e:e+1) = K(e:e+1, e:e+1) + ke;
    F(e:e+1) = F(e:e+1) + fe;
end

% ------------------------
% APPLY POINT LOAD at x=L/3
% ------------------------
xP = L/3;

% Find element containing xP
eP = floor(xP/Le) + 1;
if eP > N
    eP = N;
end

x1 = (eP-1)*Le;
x2 = eP*Le;

% Shape functions
N1 = (x2 - xP)/Le;
N2 = (xP - x1)/Le;

F(eP)   = F(eP)   + P*N1;
F(eP+1) = F(eP+1) + P*N2;

% ------------------------
% APPLY BOUNDARY CONDITION (Top fixed)
% ------------------------
K(1,:) = 0;
K(:,1) = 0;
K(1,1) = 1;
F(1) = 0;

% ------------------------
% SOLVE
% ------------------------
u = K\F;

% ------------------------
% POST PROCESSING
% ------------------------
strain = zeros(N,1);
stress = zeros(N,1);

for e=1:N
    strain(e) = (u(e+1)-u(e))/Le;
    stress(e) = E*strain(e);
end

% Display
disp('Nodal Displacements:')
disp(u)

disp('Element Stress:')
disp(stress)

% Bottom displacement
disp(['Bottom displacement = ', num2str(u(end))])