% Problem Given
% segment 1-2 l = 0.5 m dia = 50 mm
% segment 2-3 l = 1 m dia = 20 mm
% segment 3-4 l = 1.5 m dia = 30 mm
% force at node 2 = 100 kN towards right
% force at node 3 = 40 kN towards left
% force at node 4 = 20 kN towards left
% E = 100 GPa

format long

lengths = [0.5 1 1.5]; % in meters
diameters = [0.05 0.02 0.03]; % in meters
forces = [100e3 -40e3 -20e3]; % forces in Newtons
E = 100e9;

areas = pi/4.*diameters.^2; % in m^2

k = (areas.*E)./lengths;


% Assembled stiffnes matrix K
non = 4; % number of nodes
K = zeros(4);

for i = 1:non-1
    K(i:i+1, i:i+1) = K(i:i+1, i:i+1) + (k(i)*[1 -1; -1 1]);
end



% The node 1 is fixed so it does not move, the displacement is zero. So
% displacement at node 1 is zero - q1 = 0

K_reduced = K(2:4, 2:4);
u = K_reduced\(forces)';

disp("Results: Displacements at node 2,3, and 4")
fprintf("q2 = %.4f mm\n", u(1)*1e3);
fprintf("q3 = %.4f mm\n", u(2)*1e3);
fprintf("q4 = %.4f mm\n", u(3)*1e3);