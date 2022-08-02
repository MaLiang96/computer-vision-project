function X=get_space_coordinate(x,d,n)
%x=[x1,x2....xn] are n point, they are on the same plane n'*X=d 
%x1=[x11;x12;1] homogeneous coordinate of one point
%d is the distance of this plane to camera
%n=[n1;n2;n3], normal vector of the plane
if size(x,1)~=3
    error("size(x,1)~=3")
end
lambda_reciprocal =1/d*n'*x;
X=x./[lambda_reciprocal;lambda_reciprocal;lambda_reciprocal];
end