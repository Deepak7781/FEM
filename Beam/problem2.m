% EI = 9000 kNm2
% q0 = 30 kN/m

EI = 9000e3; % Convert EI to N/m^2
q0 = 30e3;   % Convert q0 to N/m

L = 6; % m

numDOF = 2;
numElements = 2;
numNodes = numElements + 1;

% Calculate the length of each element
elementLength = L / numElements;

elementConnectivity = [1 2; 2 3];

K = zeros(numNodes*numDOF);

for i = 1:numElements
    l = elementLength;
    k = (EI/(l^3))*[12 6*l -12 6*l; 
                    6*l 4*l^2 -6*l 2*l^2; 
                    -12 -6*l 12 -6*l; 
                    6*l 2*l^2 -6*l 4*l^2];
    disp(k)

    indices = [elementConnectivity(i,1)*numDOF - 1, elementConnectivity(i,1)*numDOF;
               elementConnectivity(i,2)*numDOF - 1, elementConnectivity(i,2)*numDOF];
    disp(indices)
    K(indices, indices) = K(indices, indices) + k;
end


