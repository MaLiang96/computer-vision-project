function view = inpaint(G1_pixel_cam2,G2_pixel_cam2,G3_pixel_cam2,G4_pixel_cam2,G5_pixel_cam2,height,length)

G1_pixel_cam2 = round(G1_pixel_cam2);
G2_pixel_cam2 = round(G2_pixel_cam2);
G3_pixel_cam2 = round(G3_pixel_cam2);
G4_pixel_cam2 = round(G4_pixel_cam2);
G5_pixel_cam2 = round(G5_pixel_cam2);

view=zeros(height,length,3);

%%up
 for i=1:size(G1_pixel_cam2,2)
     if 0<G1_pixel_cam2(2,i) && G1_pixel_cam2(2,i)<height+1 && 0<G1_pixel_cam2(1,i) && G1_pixel_cam2(1,i)<length+1
         view(G1_pixel_cam2(2,i),G1_pixel_cam2(1,i),:) = G1_pixel_cam2(3:5,i);
     end
 end

%%right
 for i=1:size(G2_pixel_cam2,2)
     if 0<G2_pixel_cam2(2,i) && G2_pixel_cam2(2,i)<height+1 && 0<G2_pixel_cam2(1,i) && G2_pixel_cam2(1,i)<length+1
         view(G2_pixel_cam2(2,i),G2_pixel_cam2(1,i),:) = G2_pixel_cam2(3:5,i);
     end
 end

%%back
for i=1:size(G3_pixel_cam2,2)
    if 0<G3_pixel_cam2(2,i) && G3_pixel_cam2(2,i)<height+1 && 0<G3_pixel_cam2(1,i) && G3_pixel_cam2(1,i)<length+1
        view(G3_pixel_cam2(2,i),G3_pixel_cam2(1,i),:) = G3_pixel_cam2(3:5,i);
    end
end

%%bottom
 for i=1:size(G4_pixel_cam2,2)
     if 0<G4_pixel_cam2(2,i) && G4_pixel_cam2(2,i)<height+1 && 0<G4_pixel_cam2(1,i) && G4_pixel_cam2(1,i)<length+1
         view(G4_pixel_cam2(2,i),G4_pixel_cam2(1,i),:) = G4_pixel_cam2(3:5,i);
     end
 end

%%left
 for i=1:size(G5_pixel_cam2,2)
     if 0<G5_pixel_cam2(2,i) && G5_pixel_cam2(2,i)<height+1 && 0<G5_pixel_cam2(1,i) && G5_pixel_cam2(1,i)<length+1
         view(G5_pixel_cam2(2,i),G5_pixel_cam2(1,i),:) = G5_pixel_cam2(3:5,i);
     end
 end

%%get the picture without inpaint
view = uint8(view);
%figure();
%imshow(view);

%%get picture's mask
mask = logical(zeros(size(view,1),size(view,2)));

%%use inpaintCoherent
% tic
% mask(view(:,:,1)==0 & view(:,:,2)==0 & view(:,:,1)==0) = 1;
% view = inpaintCoherent(view,mask);
% toc

%%use inpaintExemplar
% tic
% mask(view(:,:,1)==0 & view(:,:,2)==0 & view(:,:,1)==0) = 1;
% view = inpaintExemplar(view,mask);
% toc

%%use regionfill
%tic
mask(view(:,:,1)==0) = 1;
view_r = regionfill(view(:,:,1),mask);
% figure();
% imshow(mask);
mask(view(:,:,2)==0) = 1;
view_g = regionfill(view(:,:,2),mask);
% figure();
% imshow(mask);
mask(view(:,:,3)==0) = 1;
view_b = regionfill(view(:,:,3),mask);
% figure();
% imshow(mask);
%toc
view(:,:,1) = view_r;
view(:,:,2) = view_g;
view(:,:,3) = view_b;
% figure();
% imshow(view_r);
% figure();
% imshow(view_g);
% figure();
% imshow(view_b);

%%show the final picture 
figure();
imshow(view);

end