function heart=get_triangle_heart(p1,p2,p3)
%the function calculate the heart coordinate of a given triangle
%the triangle is defined by three points p1 p2 p3
%p1=[x1;y1]
%heart=[xh;yh]
x1=p1(1,1);
y1=p1(2,1);
x2=p2(1,1);
y2=p2(2,1);
x3=p3(1,1);
y3=p3(2,1);

syms x y
    %%
   
    equation_1=(y3-y2)*(y1-y )+(x1-x )*(x3-x2);
    equation_2=(y2-y1)*(y3-y )+(x3-x )*(x2-x1);
    [x0,y0]=solve(equation_1,equation_2,x,y);
    heart=double([x0;y0]);
end