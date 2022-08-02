function d=get_d(reference_point,reference_distance,d_relation,n1)
%this function returns d=[d1;d2;d3;d4;d5]
%di is the distance between camera and plane i
% d_relation=[d1;d2;d3;d4;d5]/d1=[1;d2/d1;d3/d1;d4/d1;d5/d1]
%reference_point=[x;y;1],a point in the ceiling (the first plane)
%reference_distance is the distance between reference_point and camera
%n1=[n11;n12;n13] is the normal vector of the ceiling
if n1'*n1~=1
    warning("n1 unnormalized");
    n1=n1/(n1'*n1)^0.5;%normalization
end
if reference_point(3,1)~=1
    error("reference_point is not homogeneous coordinate")
end
d1=reference_distance*n1'*reference_point;%plane equation
d=d1*d_relation;
if d1<0
    warning("d1 may be incorrect");
end
end



