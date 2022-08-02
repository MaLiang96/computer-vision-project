function f=estimate_f(img_length,img_width,vison_angle)
%This function calculates the focal length of the camera (unit : pixel)
%The vision_angel is estimated by the user (unit:degree)
%We assume the vision center is the img center
alpha=vison_angle*pi/180;%degree to rad
f=(img_length^2+img_width^2)^0.5/(tan(0.5*alpha))/2;
end