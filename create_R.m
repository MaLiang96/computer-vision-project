function R=create_R(theta_x,theta_y,theta_z)
x=theta_x*pi/180;
y=theta_y*pi/180;
z=theta_z*pi/180;
Rx=[1 0 0;0 cos(x) sin(x);0 -sin(x) cos(x)];
Ry=[cos(y) 0 -sin(y);0 1 0;sin(y) 0 cos(y)];
Rz=[cos(z) sin(z) 0;-sin(z) cos(z) 0;0 0 1];
R = Rz*Ry*Rx;
end