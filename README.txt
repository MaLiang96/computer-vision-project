cv\_challenge
=============

This project use Matlab 2022a or higher version

Toolbox
=======

1 Symbolic Math Toolbox

2 Image Proccessing Toolbox

Introduction
============

Our program can process pictures of various perspectives and restore
them to 3D scenes. Users can select new camera positions (TranslationX,
Y, Z) and camera angles (Rotation X, Y, Z) to generate new pictures. The
default mode can only handle single vanishing point photos, and the user
can only change the position and size of the rectangle. Click Multiple
Vanishing Points Mode to enter the multi-vanishing point mode, the user
can move the 4 vertices of the rectangle to turn it into any
quadrilateral

![image](https://github.com/Rullocu/cv_challenge/blob/main/picture/GUI2022.png)


Usage
============
Run the main.m file to open GUI , where you can select input image and choose arbitrary R T parameters via the following 6 variables:
  Rotation X,Y,Z: Euler angles of the Rotation matrix from the origin camera to the second camera 
  Translation X,Y,Z: The position of the second camera in the origin camera coordinate system 

Another input variable is the vision_angle, user must estimate the vision angle correctly in order to obatin the best reconstruction effect

  vision_angle: The angle between the diagonal corner of the image loaded
  by the user and the origin of the old camera coordinate system

  **IMPORTANT:
  If vision_angle is too small, it may cause error when processing 2-vanishing-points image. Please make sure to choose big enough vision_angle, e.g. 140


Implementation
==============

one point perspective
---------------------

**Input**

![one point perspective
Input](https://github.com/Rullocu/cv_challenge/blob/main/picture/one%20point%20perspective%20Input.png)

**Output**

![one point perspective
output](https://github.com/Rullocu/cv_challenge/blob/main/picture/one%20point%20perspective%20Output.png)

two point perspective
---------------------

**Input**

![two point perspective
input](https://github.com/Rullocu/cv_challenge/blob/main/picture/Two%20point%20perspective%20Input.png)

**Output**

![two point perspective
output](https://github.com/Rullocu/cv_challenge/blob/main/picture/Two%20point%20perspective%20Output.png)
