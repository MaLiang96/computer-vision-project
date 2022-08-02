function y=is_small_angle(P,angle_max)
%This function can judge if angle of the two lines is  smaller than angle_max
%angle_max is degree
%The first line is determined by P1 and P2
%The second line is determined by P3 and P4
%P = [P1,P2,P3,P4]
%y is bool
if size(P,2)~=4
    error(" size(P,2)~=4");
end

line1=P(1:2,1)-P(1:2,2);
line2=P(1:2,3)-P(1:2,4);
angle_max=angle_max*pi/180;
angle=min(abs(acos(dot(line1,line2)/(norm(line1)*norm(line2)))),abs(acos(-dot(line1,line2)/(norm(line1)*norm(line2)))));
y= (angle<angle_max);
end