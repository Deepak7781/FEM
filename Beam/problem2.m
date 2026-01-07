format long

% EI = 9000 kNm2
% q0 = 30 kN/m

EI = 9000e3; % Convert EI to Nm^2
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

    indices = [elementConnectivity(i,1)*numDOF - 1, elementConnectivity(i,1)*numDOF elementConnectivity(i,2)*numDOF - 1, elementConnectivity(i,2)*numDOF];
    disp(indices)
    K(indices, indices) = K(indices, indices) + k;
end

% As both ends are fixed q1, q2, q5, q6 = 0

fixedEnd = [1 2 size(K,1)-1 size(K,1)];

% calculating applied forces

freeEnd = setdiff(1:numDOF*numNodes , fixedEnd);

F = zeros(numNodes*numDOF, 1);

for i = freeEnd

    if rem(i,2) ~= 0
        F(i) = -q0*elementLength/2;
    else
        F(i) = q0*(elementLength^2)/12;
    end
end


q = zeros(numDOF*numNodes, 1);

q(freeEnd) = K(freeEnd, freeEnd)\F(freeEnd);

disp('v2 (m) and theta2 (rad)')
disp(q(freeEnd));

% Calculation of reaction forces

for i = fixedEnd
    F(i) = K(i,freeEnd)*q(freeEnd);
end

% Display the calculated reaction forces
disp('Reaction Forces at Fixed Ends (N):');
disp(F(fixedEnd));