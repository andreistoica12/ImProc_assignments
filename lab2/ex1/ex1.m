clear all;

a=0;
b=0;
c=1;

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
end

% Exercise 1c
if c==1
    th = otsuThreshold(img);
end




