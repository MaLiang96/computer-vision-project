function N=get_N(v_homo)
% This function calculate the 3 normal vectors of the box
%N=[n1,n2,n3]
if size(v_homo,1)~=3
    error("v_homo must be homogenous coordinates")
end

v1=v_homo(:,1);
if v1(3,1)<0.01
    v1=[1;0;0];
end
v2=v_homo(:,2);
if v2(3,1)<0.01
    v2=[0;1;0];
end
v3=v_homo(:,3);
n1_unnomalized=v1;
n1=n1_unnomalized/(n1_unnomalized'*n1_unnomalized)^0.5;
n2_unnomalized=v2;
n2=n2_unnomalized/(n2_unnomalized'*n2_unnomalized)^0.5;
n3_unnomalized=v3;
n3=n3_unnomalized/(n3_unnomalized'*n3_unnomalized)^0.5;
if n1(1,1)<0
        n1=-n1;%sign convention, n1 must be possitive in x direction
end
if n2(2,1)<0
        n2=-n2;%sign convention, n2 must be possitive in y direction
end
if n3(3,1)<0
        n3=-n3;%sign convention, n3 must be possitive in z direction
end

N=[n1,n2,n3];

    



%check if the N is orthogonal matrix
if abs(sum(sum(N*N'-[1 0 0;0 1 0;0 0 1])))>1e-10
        warning("N may be incorrect, the error of N= ");
        sum(sum(N*N'-[1 0 0;0 1 0;0 0 1]))
end
end