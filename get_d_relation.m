function d_relation=get_d_relation(N,X)
%this function returns d_relation=[d1;d2;d3;d4;d5]/d1=[1;d2/d1;d3/d1;d4/d1;d5/d1]
%di is the distance between camera and plane i
%N=[n1,n2,n3]  is a 3*3 matrix
%n1=[n11; n21; n31], it is the normal vector of plane 1
%X=[x1,x2,x3,x4] is a 3*4 matrix, containing the homogeneous coordinates of the four ecker
%points
if size(N,1)~=3 || size(N,2) ~=3 || size(X,1)~=3 || size(X,2)~=4
    error('N or X dimension incorrect');
end

A=N'*X;
M=zeros(8,5);
%equation for point1
M(1,1)=A(2,1)*A(3,1);
M(1,5)=-A(1,1)*A(3,1);
M(2,1)=A(2,1)*A(3,1);
M(2,3)=-A(1,1)*A(2,1);

%equation for point2
M(3,1)=A(2,2)*A(3,2);
M(3,2)=-A(1,2)*A(3,2);
M(4,1)=A(2,2)*A(3,2);
M(4,3)=-A(1,2)*A(2,2);

%equation for point3
M(5,2)=-A(1,3)*A(3,3);
M(5,4)=A(2,3)*A(3,3);
M(6,3)=-A(1,3)*A(2,3);
M(6,4)=A(2,3)*A(3,3);

%equation for point3
M(7,4)=A(2,4)*A(3,4);
M(7,5)=-A(1,4)*A(3,4);
M(8,3)=-A(1,4)*A(2,4);
M(8,4)=A(2,4)*A(3,4);

%solve the equation M*d=(0;0;0;0;0;0;0;0) using svd()

[~,~,V]=svd(M);
d=V(:,end);
d=d/d(1,1);
Rank_M=rank(M);
if Rank_M>4
    %warning("Rank_M>4");
end
d_error=M*d/(sum(sum(abs(M))));
d_relation=d;
end


