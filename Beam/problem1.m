% Using FEM, obtain nodal displacements and slopes. The flexural rigidity
% is ubniform throughout.

% No.of nodes = 4, No.of Elements = 4

numDOF = 2;
numNodes = 4;
numElements = 3;
nodalDisplacements = zeros(numNodes, 1);
EI = 200e6;

elementConnectivity = [1, 2; 2, 3; 3, 4]; 


AB_L = 3;
BC_L = 3;
CD_L = 4;
elementLengths = [AB_L, BC_L, CD_L];

K = zeros(numNodes*numDOF);

for i = 1:length(elementLengths)
    L = elementLengths(i);
    row1 = [12 6*L -12 6*L];
    row2 = [6*L 4*L^2 -6*L 2*L^2];
    row3 = [-12 -6*L 12 -6*L];
    row4 = [6*L 2*L^2 -6*L 4*L^2];
    k = (EI/L^3)*[row1; row2; row3; row4];
    % Assemble the global stiffness matrix
    indices = [elementConnectivity(i, 1)*numDOF-1, elementConnectivity(i, 1)*numDOF, ...
        elementConnectivity(i, 2)*numDOF-1, elementConnectivity(i, 2)*numDOF];
    disp(indices)
    K(indices, indices) = K(indices, indices) + k;
end

F = zeros(numNodes*numDOF, 1);


F(4) = 700; % Nm
F(7) = 9000; % N

fixedDOF = [1 2 5];

K_reduced = K([3 4 6 7 8], [3 4 6 7 8]);

F_reduced = F([3 4 6 7 8]);

q = K_reduced\F_reduced;

fprintf('v2 = %.4f m\n', q(1));
fprintf('theta2 = %.4f rad\n', q(2));
fprintf('theta3 = %.4f rad\n', q(3));
fprintf('v4 = %.4f m\n', q(4));
fprintf('theta4 = %.4f rad\n', q(5));
