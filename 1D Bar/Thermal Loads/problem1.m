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


% thermal loads

force = zeros(1, num_elements);
force(1:2) = areaAB*E_AB*dt*alpha_AB;
force(3:4) = areaBC*E_BC*dt*alpha_BC;

f = zeros(1, non);

for i = 1:num_elements
    f(i) = f(i) - force(i);
    f(i+1) = f(i+1) + force(i);
end


% Boundary Conditions
% Displacement at 1 is 0.6 mm
q1 = -0.6e-3;
q5 = 0;


F = f(2:end-1);

for i = 1:3
    F(i) = f(i+1) - K(i+1,1)*q1;
end

U_reduced = K(2:4, 2:4)\F';

U = [0.6e-3; U_reduced; 0];

sigma = zeros(num_elements,1);
for i = 1:4
    if i < 3
        sigma(i) = E_AB*([-1/(lengthAB/2) 1/(lengthAB/2)]*U(i:i+1)) - alpha_AB * dt;
    else
        sigma(i) = E_BC*[-1/(lengthBC/2) 1/(lengthBC/2)]*U(i:i+1) - alpha_BC * dt;
    end
end
