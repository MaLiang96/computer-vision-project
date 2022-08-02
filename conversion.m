function conversion(X_pixel, v_3, height, length, img_rgb, vision_angle, R, T)
%%get pixel groups
tic
v_pixel=get_vanish_points(X_pixel,v_3);
[G1,G2,G3,G4,G5,p]=dividegroup(img_rgb,X_pixel,v_pixel);
G1_pixel=G1(1:2,:);%pixel coordinate [x;y] of every pixel
G1_rgb=G1(3:5,:);%rgb value [r;g;b] of every pixel
G2_pixel=G2(1:2,:);
G2_rgb=G2(3:5,:);
G3_pixel=G3(1:2,:);
G3_rgb=G3(3:5,:);
G4_pixel=G4(1:2,:);
G4_rgb=G4(3:5,:);
G5_pixel=G5(1:2,:);
G5_rgb=G5(3:5,:);

%%estimate focal length f, calculate calibration matrix K
f=estimate_f(size(img_rgb,1),size(img_rgb,2),vision_angle);
K=get_K(v_pixel,f);

%%transform pixel coordinate to homogeneous coordinates 
X_homo=K\[X_pixel(1:2,:);1 1 1 1];
v_homo=K\v_pixel;
G1_homo=K\[G1_pixel(1:2,:);ones(1,size(G1_pixel,2))];
G2_homo=K\[G2_pixel(1:2,:);ones(1,size(G2_pixel,2))];
G3_homo=K\[G3_pixel(1:2,:);ones(1,size(G3_pixel,2))];
G4_homo=K\[G4_pixel(1:2,:);ones(1,size(G4_pixel,2))];
G5_homo=K\[G5_pixel(1:2,:);ones(1,size(G5_pixel,2))];

%%calculate the normal vectors n1, n2 and n3 of the box
N=get_N(v_homo);

%%calculate d1~d5 for the 5 planes
d_relation=get_d_relation(N,X_homo);
   %choose the center point of the first colume of pixels as reference
reference_point_pixel=[ceil(0.5*size(img_rgb,2));1;1];
reference_point_homo=K\reference_point_pixel;
reference_distance=5;%arbitary value
d=get_d(reference_point_homo,reference_distance,d_relation,N(:,1));

%%calculate the space postion of all pixels from G1 to G5 in the first
%%camera
G1_space_cam1=get_space_coordinate(G1_homo,d(1,1),N(:,1));
G2_space_cam1=get_space_coordinate(G2_homo,d(2,1),N(:,2));
G3_space_cam1=get_space_coordinate(G3_homo,d(3,1),N(:,3));
G4_space_cam1=get_space_coordinate(G4_homo,d(4,1),N(:,1));
G5_space_cam1=get_space_coordinate(G5_homo,d(5,1),N(:,2));

%%Euklidische Transform to the second camera
G1_space_cam2=R*G1_space_cam1-R*T;
G2_space_cam2=R*G2_space_cam1-R*T;
G3_space_cam2=R*G3_space_cam1-R*T;
G4_space_cam2=R*G4_space_cam1-R*T;
G5_space_cam2=R*G5_space_cam1-R*T;

%%delete the koordinates behind camera plane
koordinates_index = find(G1_space_cam2(3,:)<1);
G1_space_cam2(:,koordinates_index) = [];
G1_rgb(:,koordinates_index) = [];

koordinates_index = find(G2_space_cam2(3,:)<1);
G2_space_cam2(:,koordinates_index) = [];
G2_rgb(:,koordinates_index) = [];

koordinates_index = find(G3_space_cam2(3,:)<1);
G3_space_cam2(:,koordinates_index) = [];
G3_rgb(:,koordinates_index) = [];

koordinates_index = find(G4_space_cam2(3,:)<1);
G4_space_cam2(:,koordinates_index) = [];
G4_rgb(:,koordinates_index) = [];

koordinates_index = find(G5_space_cam2(3,:)<1);
G5_space_cam2(:,koordinates_index) = [];
G5_rgb(:,koordinates_index) = [];

%%obtain projection of all the pixels in the second camera 
G1_homo_cam2=G1_space_cam2./[G1_space_cam2(3,:);G1_space_cam2(3,:);G1_space_cam2(3,:)];
G2_homo_cam2=G2_space_cam2./[G2_space_cam2(3,:);G2_space_cam2(3,:);G2_space_cam2(3,:)];
G3_homo_cam2=G3_space_cam2./[G3_space_cam2(3,:);G3_space_cam2(3,:);G3_space_cam2(3,:)];
G4_homo_cam2=G4_space_cam2./[G4_space_cam2(3,:);G4_space_cam2(3,:);G4_space_cam2(3,:)];
G5_homo_cam2=G5_space_cam2./[G5_space_cam2(3,:);G5_space_cam2(3,:);G5_space_cam2(3,:)];

G1_pixel_cam2=K*G1_homo_cam2;
G2_pixel_cam2=K*G2_homo_cam2;
G3_pixel_cam2=K*G3_homo_cam2;
G4_pixel_cam2=K*G4_homo_cam2;
G5_pixel_cam2=K*G5_homo_cam2;

%%match coordinates with pixel values
G1_pixel_cam2(3:5,:)=G1_rgb;
G2_pixel_cam2(3:5,:)=G2_rgb;
G3_pixel_cam2(3:5,:)=G3_rgb;
G4_pixel_cam2(3:5,:)=G4_rgb;
G5_pixel_cam2(3:5,:)=G5_rgb;

%%inpaint algorithm
inpaint(G1_pixel_cam2,G2_pixel_cam2,G3_pixel_cam2,G4_pixel_cam2,G5_pixel_cam2,height,length);
toc
%show the 3d box
%reconstruct_3d_box(10,G1_space_cam1,G2_space_cam1,G3_space_cam1,G4_space_cam1,G5_space_cam1);
%reconstruct_3d_box(11,G1_space_cam2,G2_space_cam2,G3_space_cam2,G4_space_cam2,G5_space_cam2);

%reconstruct_3d_box(G1_space_cam2,G2_space_cam2,G3_space_cam2,G4_space_cam2,G5_space_cam2)
%%GUI output
