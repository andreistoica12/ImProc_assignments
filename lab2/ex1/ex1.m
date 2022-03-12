clear all;

a=0;
b=1;
c=0;

img = imread('images/lena.pgm');


% Exercise 1a
if a==1
img = thresholdImage(100, img, 0, 255);
imshow(img);
end

% Exercise 1b
if b==1
    epsilon = 0.1;
    th = iterativeThreshold(img, epsilon);
    img = thresholdImage(th, img, 0, 255);
    figure();imshow(img);
end

