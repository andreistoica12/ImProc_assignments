clear all;

a=1;
b=0;
c=0;

% Exercise 1a
if a==1
img = imread('images/lena.pgm');
img = thresholdImage(100, img, 0, 255);
imshow(img);
end