function V=get_vanish_points(P,v0)
%This function can calculate the 3 vanish points v1,v2,v3
%V=[v1,v2,v3],  3*3 matrix
%P = [P1,P2,P3,P4] are 4 points given by user
%Pi =[xi;yi;1] or [xi;yi], (homogeneous) coordinate for point i
%v0 is the center vanish point given by user
%if vanish point vi is not infinite far away, vi=(xi;yi;1)
%if vanish point vi is infinite far away, vi=(~;~;0)
if size(P,2)~=4
    error(" size(P,2)~=4");
end
if size(v0,1)<2
    error("size(v0,1)<2");
end
%v1 is the intersection of line P1P4 and line P2P3
v1=get_intersection([P(:,1),P(:,4),P(:,2),P(:,3)]);
%v2 is the intersection of line P1P2 and line P3P4
v2=get_intersection([P(:,1),P(:,2),P(:,3),P(:,4)]);
%v3 is given by user
v3=[v0(1:2,1);1];

if is_small_angle([P(:,1),P(:,4),P(:,2),P(:,3)],3)%if the angle is smaller than 3 degree
    v1=[1;0;0];%we assume the two lines are paralle, v1 is infinit far away
end
if is_small_angle([P(:,1),P(:,2),P(:,3),P(:,4)],3)%if the angle is smaller than 3 degree
    v2=[0;1;0];%we assume the two lines are paralle, v2 is infinit far away
end
V=double([v1,v2,v3]);
end
