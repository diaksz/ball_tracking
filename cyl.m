% r = linspace(0,2);
% theta = linspace(0,pi);
% [r thet] = meshgrid(r,theta);
% z = R*cos
 
[A,B,C] = cylinder([.05 .05]);

A = A + 2;
B = B + 2;
C = C + 2;
surf(A,B,C);