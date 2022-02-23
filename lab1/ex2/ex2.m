close all; % close open figure windows
clear all; % remove items from workspace

a = 1;
b = 0;

imname='images\peppers'; % name of the input image
inputfile = [imname,'.pgm'];
im = imread(inputfile); % read input image
figure(1)
imshow(im)

% Exercise 2a
if a==1
    stretched = contrastStretch(im, 0, 255);
    figure(2)
    imshow(stretched);
    min(stretched(:))
    max(stretched(:))
end

% Exercise 2b
if b==1
   
    [~,h, P] = histogramEqualization(im, 0, 255);
    sum(h)
    sum(P)
    %bar(h);
end
% Exercise 2c