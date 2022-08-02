function K=get_K(v,f)
%K is the 3*3 calibration matrix x'=Kx
% v=[v1 v2 v3], are three vanishing point in pixel coordinate
%if vanish point vi is not infinite far away, vi=(xi;yi;1)
%if vanish point vi is infinite far away, vi=(~;~;0)
%f is the focal length in pixel units

%one point perspective, v1 and v2 are infinite far away
if v(3,1)<0.999 && v(3,2)<0.999
    message="This is 1 point perspective"
    ox=v(1,3);
    oy=v(2,3);
    s=f;
    K=[0 s ox;-s 0 oy;0 0 1];
end
%two point perspective, v1 is infinite far away
if v(3,1)<0.999 && v(3,2)>0.999
    message="This is horizontal 2 point perspective"
    oy=v(2,3);
    v1x=v(1,2);
    v3x=v(1,3);
    %relation between vision center oy and vanishing points
    if (v1x+v3x)^2-4*(f^2+v1x*v3x)<0
        error("vision angle too small, please choose a larger vision_angle in the GUI.");
    end
    ox1=0.5*((v1x+v3x)+((v1x+v3x)^2-4*(f^2+v1x*v3x))^0.5);
    ox2=0.5*((v1x+v3x)-((v1x+v3x)^2-4*(f^2+v1x*v3x))^0.5);
    ox=ox2;
    if abs(ox-v3x)>abs(ox1-v3x)%choose the oy which is the nearest to v3
        ox=ox1;
    end
    s=f;
    K=[0 s ox;-s 0 oy;0 0 1];
end
%two point perspective, v2 is infinite far away
if v(3,1)>0.999 && v(3,2)<0.999
    message="This is vertical 2 point perspective"
    ox=v(1,3);
    v1y=v(2,1);
    v3y=v(2,3);
    %relation between vision center oy and vanishing points
    if (v1y+v3y)^2-4*(f^2+v1y*v3y)<0
        error("vision angle too small, please choose a larger vision angle.");
    end
    oy1=0.5*((v1y+v3y)+((v1y+v3y)^2-4*(f^2+v1y*v3y))^0.5);
    oy2=0.5*((v1y+v3y)-((v1y+v3y)^2-4*(f^2+v1y*v3y))^0.5);
    oy=oy2;
    if abs(oy-v3y)>abs(oy1-v3y)%choose the oy which is the nearest to v3
        oy=oy1;
    end
    s=f;
    K=[0 s ox;-s 0 oy;0 0 1];
end
%three point perspective, no vanishing point is infinite faraway
if v(3,1)>0.999 && v(3,2)>0.999
    message="This is 3 point perspective"
    heart=get_triangle_heart(v(:,1),v(:,2),v(:,3));
    f1=(abs((heart-v(1:2,1))'*(heart-v(1:2,2))))^0.5;
    if (heart-v(1:2,1))'*(heart-v(1:2,2))>0
        warning("wrong perspective, please redraw ");
    end
    f2=(abs((heart-v(1:2,1))'*(heart-v(1:2,3))))^0.5;
    f3=(abs((heart-v(1:2,3))'*(heart-v(1:2,2))))^0.5;
    ox=heart(1,1);
    oy=heart(2,1);
    f=(f1+f2+f3)/3;
    s=f;
    K=[0 s ox;-s 0 oy;0 0 1];

end



end