% Given data

% Increase in temperature dt = 100 C
% AB - Brass, Area = 1200 mm^2, length = 400 mm, E = 105 GPa, CoefficienT
% of linear expansion, alpha = 18x10^-6 /C
% BC - Aluminium, Area = 1500 mm^2, length = 500 mm, E = 70 GPa, alpha =
% 23x10^-6/C
% Compute the stress developed in two materials


dt = 100; % C

areaAB = 1200e-6; % \m^2
lengthAB = 0.4; % m
E_AB = 105e9; % Pa
alpha_AB = 18e-6; % /C

areaBC = 1500e-6; % mm^2
lengthBC = 0.5; % m
alpha_BC = 23e-6; % /C
E_BC = 70e9; % Pa

num_elements = 4;
non = num_elements + 1;

% Element stiffness

k = ([areaAB areaAB areaBC areaBC].*[E_AB E_AB E_BC E_BC])./[lengthAB/2 lengthAB/2 lengthBC/2 lengthBC/2];

% Global stiffness matrix

K = zeros(non);

for i = 1:num_elements
    K(i:i+1, i:i+1) = K(i:i+1, i:i+1) + k(i)*[1 -1;-1 1];
end



