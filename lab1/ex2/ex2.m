close all; % close open figure windows
clear all; % remove items from workspace

% Exercise 2a
imname='images\blurrymoon'; % name of the input image
inputfile = [imname,'.pgm'];
im = imread(inputfile); % read input image

figure(1)
imshow(im)

stretched = contrastStretch(im, 0, 255);
figure(2)
imshow(stretched);

% Exercise 2b
% Exercise 2c