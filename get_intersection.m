function X=get_intersection(P)
%This function calculates the intersection point X=[x;y;1] of two lines
%The first line is determined by P1 and P2
%The second line is determined by P3 and P4
%P = [P1,P2,P3,P4]
%Pi =[xi;yi;1] or [xi;yi], (homogeneous) coordinate for point i
%If line 1 and line 2 are paralle, this fuction returns a vector X=[x;y;0],
%This vector X=[x;y;0] is paralle to the two lines
if size(P,2)~=4
    error(" size(P,2)~=4");
end

if rank([P(:,1)-P(:,2),P(:,3)-P(:,4)])==1 %situation 1: when two lines are paralle
    X=P(:,1)-P(:,2);
else                                     %situation 2:when two lines intersect
    syms x y
    %%
    % 
    %  PREFORMATTED
    %  TEXT
    % 
    equation_1=(P(1,2)-P(1,1))*(y-P(2,1))-(x-P(1,1))*(P(2,2)-P(2,1));
    equation_2=(P(1,4)-P(1,3))*(y-P(2,3))-(x-P(1,3))*(P(2,4)-P(2,3));
    [x0,y0]=solve(equation_1,equation_2,x,y);
    X=double([x0;y0;1]);
end

end



