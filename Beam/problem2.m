% EI = 9000 kNm2
% q0 = 30 kN/m

EI = 9000e6; % Convert EI to N/m^2
q0 = 30e3;   % Convert q0 to N/m

L = 6; % m

numElements = 2;
numNodes = numElements + 1;

% Calculate the length of each element
elementLength = L / numElements;