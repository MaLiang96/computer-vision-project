function y=reconstruct_3d_box(fig_name,G1_space,G2_space,G3_space,G4_space,G5_space)
%This function is for debugging
%This function plot the points in 3d space
figure(fig_name);
%plot xyz coordinate 
plot3([0,1],[0,0],[0,0],'r');%x axel
hold on
plot3([0,0],[0,1],[0,0],'g');%y axel
hold on
plot3([0,0],[0,0],[0,1],'b');%z axel
hold on
%plot  G1_space in 3d space
if size(G1_space,2)>0
    scatter3(G1_space(1,:),G1_space(2,:),G1_space(3,:),'green');
end
hold on

%plot  G2_space in 3d space
if size(G2_space,2)>0
    scatter3(G2_space(1,:),G2_space(2,:),G2_space(3,:),'blue');
end
hold on

%plot  G3_space in 3d space
if size(G3_space,2)>0
    scatter3(G3_space(1,:),G3_space(2,:),G3_space(3,:),'*');
end
hold on

%plot  G4_space in 3d space
if size(G4_space,2)>0
    scatter3(G4_space(1,:),G4_space(2,:),G4_space(3,:),'red');
end
hold on

%plot  G5_space in 3d space
if size(G5_space,2)>0
    scatter3(G5_space(1,:),G5_space(2,:),G5_space(3,:),'yellow');
end
hold on

campos([43,-22,-87]);
camup([0,-1,0]);
xlabel("X");
ylabel("Y");
zlabel("Z");
grid on
axis equal


y="reconstruction 3d plot is done"
end