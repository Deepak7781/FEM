% Bar is fixed both ends

% Given data
% Total Length, L = 1 m
% Area 1 (at left) = 600 mm2
% Area 2 (at right) = 300 mm2
% E = 200 GPa
% alpha = 12 x 10^-6 /C
% delT = 50 C

L = 1; % Total Length in meters
A1 = 600e-6; % Area 1 in square meters
A2 = 300e-6; % Area 2 in square meters
E = 200e9; % Young's Modulus in Pascals
alpha = 12e-6; % Coefficient of thermal expansion in 1/C
delT = 50; % Temperature change in Celsius

N = 2; % number of elements
Le = L/N;
A = linspace(A1, A2, N+1);
K = zeros(N + 1);

F_thermal = zeros(N+1, 1);

for i = 1:N
    avgArea = (A(i) + A(i+1))/2;
    ke = ((avgArea*E)/Le)*[1 -1; -1 1]; % local stifness matrix
    K(i:i+1, i:i+1) = K(i:i+1, i:i+1) + ke; % Assemble global stiffness matrix
    F_thermal(i:i+1) = F_thermal(i:i+1) + E*avgArea*alpha*delT*[-1;1];
end

% Apply boundary conditions
% The first and last nodes are fixed, so the displacements at the both the ends will be zero

idx = true(N+1,1);
idx(1) = 0;
idx(end) = 0;

K_reduced = K(idx, idx);

u_reduced = K_reduced\F_thermal(idx);

u = zeros(N+1,1);
u(idx) = u_reduced;


% Reaction Forces

R = K*u - F_thermal;

% Stress in each element

sigma = E*alpha*delT;