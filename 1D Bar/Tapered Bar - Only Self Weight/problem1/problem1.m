% Tapered beam hanging verticaly from a fixed point. No other force acts on
% it except its self weight. 
% Rectangular Cross section

format long

num_elements = 2;
non = num_elements + 1; % Number of nodes 

thickness = 0.01; % m (constant)
width_start = 0.08; % m (width at node 1)
width_end = 0.04; % m (width at node non)
E = 2e11; % Pa
total_length = 0.3;
lengths = (total_length/(num_elements))*ones(1, num_elements); % m (array of element lengths)
rho = 7800; % kg/m^3
g = 9.81; % m/s^2

% widths at all nodes (linear taper)
widths_nodes = linspace(width_start, width_end, non);

% Areas at nodes
areas_nodes = widths_nodes * thickness;

% Areas for elements (average of adjacent nodes)

area_elements = zeros(1, num_elements);
for e = 1:num_elements
    area_elements(e) = (areas_nodes(e) + areas_nodes(e+1)) / 2;
end

% Element stiffnesses
k = (area_elements .* E) ./ lengths;

% Assembled Stiffness Matrix
K = zeros(non);
for e = 1:num_elements

    K(e:e+1, e:e+1) = K(e:e+1, e:e+1) + k(e) * [1 -1; -1 1];
end

% Element weights
W = area_elements .* lengths * rho * g;

%Forces at each due to self-weight
F = zeros(non, 1);
for e = 1:num_elements
    F(e) = F(e) + W(e) / 2;
    F(e+1) = F(e+1) + W(e) / 2;
end


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






