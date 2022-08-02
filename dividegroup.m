function [G1,G2,G3,G4,G5,p] = dividegroup(I,X,v);
imshow(I);
[height,length,~] = size(I);
R = double(I(:,:,1));
G = double(I(:,:,2));
B = double(I(:,:,3));
rx = X(2,:); ry = X(1,:);
vx = v(2,end); vy = v(1,end);

P = zeros(2,12);
P(:,1) = [rx(4);ry(4)];
P(:,2) = [rx(3);ry(3)];
P(:,7) = [rx(1);ry(1)];
P(:,8) = [rx(2);ry(2)];
[P(:,3),k3] = p_inter(vx,vy,P(1,1),P(2,1),'x',height);
[P(:,4),k4] = p_inter(vx,vy,P(1,2),P(2,2),'x',height);
[P(:,5),k5] = p_inter(vx,vy,P(1,1),P(2,1),'y',1);
[P(:,6),k6] = p_inter(vx,vy,P(1,2),P(2,2),'y',length);
[P(:,9),k9] = p_inter(vx,vy,P(1,7),P(2,7),'x',1);
[P(:,10),k10] = p_inter(vx,vy,P(1,8),P(2,8),'x',1);
[P(:,11),k11] = p_inter(vx,vy,P(1,7),P(2,7),'y',1);
[P(:,12),k12] = p_inter(vx,vy,P(1,8),P(2,8),'y',length);
   
% figure();
% hold on
% plot(p(1,:),p(2,:),'o');
% plot([rx;rx(1)],[ry;ry(1)]);

%%up
x_up = [P(2,7),P(2,9),P(2,10),P(2,8)];
y_up = [P(1,7),P(1,9),P(1,10),P(1,8)];
if k9<=-1
    P(:,9) = P(:,11);
    if k10>1
        P(:,10) = P(:,12);
        x_up = [P(2,7),P(2,9),1,length,P(2,10),P(2,8)];
        y_up = [P(1,7),P(1,9),1,1,P(1,10),P(1,8)];
    end
    x_up = [P(2,7),P(2,9),1,P(2,10),P(2,8)];
    y_up = [P(1,7),P(1,9),1,P(1,10),P(1,8)];
end
mask = poly2mask(x_up,y_up,height,length);
%figure()
%imshow(mask);
sum_mask = sum(mask,"all");
n = 1;
G1 = zeros(5,sum_mask);
% im_up = zeros(height, length, 3);
for i = 1:height
    for j = 1:length
        if mask(i,j)==1
            G1(:,n) = [j;i;R(i,j);G(i,j);B(i,j)];
            n = n+1;
%             im_up(i,j,1) = R(i,j);
%             im_up(i,j,2) = G(i,j);
%             im_up(i,j,3) = B(i,j);
        end
    end
end
% im_up = uint8(im_up);
% figure
% imshow(im_up)

%%right
x_right = [P(2,8),P(2,12),P(2,6),P(2,2)];
y_right = [P(1,8),P(1,12),P(1,6),P(1,2)];
if 0<k12 && k12<=1
    P(:,12) = P(:,10);
    if -1<k6 && k6<=0
        P(:,6) = P(:,4);
        x_right = [P(2,8),P(2,12),length,length,P(2,6),P(2,2)];
        y_right = [P(1,8),P(1,12),1,height,P(1,6),P(1,2)];
    end
    x_right = [P(2,8),P(2,12),length,P(2,6),P(2,2)];
    y_right = [P(1,8),P(1,12),1,P(1,6),P(1,2)];
end
mask = poly2mask(x_right,y_right,height,length);
%figure()
%imshow(mask);
sum_mask = sum(mask,"all");
n = 1;
G2 = zeros(5,sum_mask);
for i = 1:height
    for j = 1:length
        if mask(i,j)==1
            G2(:,n) = [j;i;R(i,j);G(i,j);B(i,j)];
            n = n+1;
        end
    end
end

%%back
x_back = [P(2,7),P(2,8),P(2,2),P(2,1)];
y_back = [P(1,7),P(1,8),P(1,2),P(1,1)];
mask = poly2mask(x_back,y_back,height,length);
%figure()
%imshow(mask);
sum_mask = sum(mask,"all");
n = 1;
G3 = zeros(5,sum_mask);
for i = 1:height
    for j = 1:length
        if mask(i,j)==1
            G3(:,n) = [j;i;R(i,j);G(i,j);B(i,j)];
            n = n+1;
        end
    end
end

%%bottom
x_bottom = [P(2,1),P(2,2),P(2,4),P(2,3)];
y_bottom = [P(1,1),P(1,2),P(1,4),P(1,3)];
if k4<=-1
    P(:,4) = P(:,6);
    if k3>1
        P(:,3) = P(:,5);
        x_bottom = [P(2,1),P(2,2),P(2,4),length,1,P(2,3)];
        y_bottom = [P(1,1),P(1,2),P(1,4),height,height,P(1,3)];
    end
    x_bottom = [P(2,1),P(2,2),P(2,4),length,P(2,3)];
    y_bottom = [P(1,1),P(1,2),P(1,4),height,P(1,3)];
end
mask = poly2mask(x_bottom,y_bottom,height,length);
%figure()
%imshow(mask);
sum_mask = sum(mask,"all");
n = 1;
G4 = zeros(5,sum_mask);
for i = 1:height
    for j = 1:length
        if mask(i,j)==1
            G4(:,n) = [j;i;R(i,j);G(i,j);B(i,j)];
            n = n+1;
        end
    end
end

%%left
x_left = [P(2,1),P(2,5),P(2,11),P(2,7)];
y_left = [P(1,1),P(1,5),P(1,11),P(1,7)];
if -1<k11 && k11<=0
    P(:,11) = P(:,9);
    if 0<k5 && k5<=1
        P(:,5) = P(:,3);
        x_left = [P(2,1),P(2,5),1,1,P(2,11),P(2,7)];
        y_left = [P(1,1),P(1,5),height,1,P(1,11),P(1,7)];
    end
    x_left = [P(2,1),P(2,5),1,P(2,11),P(2,7)];
    y_left = [P(1,1),P(1,5),1,P(1,11),P(1,7)];
end
mask = poly2mask(x_left,y_left,height,length);
%figure()
%imshow(mask);
sum_mask = sum(mask,"all");
n = 1;
G5 = zeros(5,sum_mask);
for i = 1:height
    for j = 1:length
        if mask(i,j)==1
            G5(:,n) = [j;i;R(i,j);G(i,j);B(i,j)];
            n = n+1;
        end
    end
end
p = [P(2,:);P(1,:)];