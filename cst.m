x1 = 0;
x2 = 1000;
x3 = 1000;
x4 = 0;
y1 = 0;
y2 = 0;
y3 = 750;
y4 = 750;

A2 = 0.5*det([1 x1 y1; 1 x2 y2; 1 x3 y3]);
A1 = 0.5*det([1 x1 y1; 1 x3 y3; 1 x4 y4]);
B2=(1/(2*A1))*[(y2-y3) 0 y3-y1 0 y1-y2 0; 0 x3-x2 0 x1-x3 0 x2-x1; x3-x2 y2-y3 x1-x3 y3-y1 x2-x1 y1-y2];
B1=(1/(2*A2))*[(y2-y4) 0 y4-y1 0 y1-y3 0; 0 x4-x3 0 x1-x4 0 x1-x3; x4-x3 y3-y4 x1-x4 y4-y1 x1-x3 y1-y3];

k1 = rand(6,6);
k2 = rand(6,6);



Element = [1 2 3; 1 3 4];

K = zeros(8);

for i = 1:size(Element, 1)
    dofNumber = [];
    for j = 1:size(Element, 2)
        node = Element(i,j);
        dofNumber = [dofNumber,2*node - 1, 2*node];
        disp(dofNumber)
    end
    if i == 1
        ke = k1;
    elseif i == 2
        ke = k2;
    end

    K(dofNumber, dofNumber) = K(dofNumber,dofNumber) + ke;
end


