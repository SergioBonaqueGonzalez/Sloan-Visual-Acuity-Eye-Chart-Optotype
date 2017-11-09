# Sloan-Visual-Acuity-Eye-Chart-Optotype
This script generates a theoretically exact optotype based on Sloan letters, usefull for visual experiments.

It generates an optotype of random Sloan letters according to a variery of specified variables:

        - Distance from the eye to the optotype in meters.
        
        - Pixel size of the screen (i.e. a LED screen) which will display the optotype (or pdi if it will be printed), in meters.
        
        - Dimensions in pixels of the screen in number of vertical and horizontal pixels.
        
        - Maximum lines of the optotype to be plotted.
        
        YOU CAN MODIFIED THESE VARIABLES DIRECTLY INTO THE SCRIPT, LINES 19-23.
        
        
As pixels number is a discrete value, only discrete values of visual acuities can be displayed accurately. Additionally, to display perfectly a Sloan letter it has to be multiply of 5 pixels in size. So, this script gives the nearest possible visual acuity values to the desired one.

It was written for my own experiments and works well for small letter size. As Sloan letters were designed almost pixel-by-pixel, I designed a 45x45 pixels version. Interpolation to smaller size works fine, I have no tested interpolation to a very big size. If there is any problem with bigger sizes, please contact me :-) .

If you use my work in a scientifical work, do not forget to include me in the acknowledgment section !

It was written by Sergio Bonaque-González  and David Carmona-Ballester

  sergiob@wooptix.com                                   dacabad2@gmail.com      
        
  https://www.linkedin.com/in/sergiobonaque/            






![My image1](/imgs/figure1.jpg)   
