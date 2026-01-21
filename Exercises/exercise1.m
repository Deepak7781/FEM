% Divide a beam of length L and uniform flecural rigidity EI into N
% elements. 
% Write a matlab code to obtain the flobal stiffness matrix (display the
% same)

L = input("Enter the length of the beam in m:"); % m 
EI = input("Enter the Flexural Rigidity of the beam in Nm^2:"); 
N = input("Enter the Number of Elements:"); % Number of elemets
DOF = 2; % For a two node bar element.
L_E = L/N;

K = zeros((N+1) * DOF);

for i = 1:N
    k = (EI / L_E^3)*[12 6*L_E -12 6*L_E;
                      6*L_E 4*(L_E^2) -6*L_E 2*(L_E^2);
                      -12 -6*L_E 12 -6*L_E;
                      6*L_E 2*(L_E^2) -6*L 4*(L_E^2)];
    idx = [(i*DOF - 1) (i*DOF) ((i+1)*DOF - 1) ((i+1)*DOF)];
    K(idx,idx) = K(idx,idx) + k;
end

disp(sparse(K))
