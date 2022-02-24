close all; % close open figure windows
clear all; % remove items from workspace

a = 1;
b = 1;

imname='images\peppers'; % name of the input image
minOut = 0;
maxOut = 255;

inputfile = [imname,'.pgm'];
imgIn = imread(inputfile); % read input image
figure()
imshow(imgIn)
title(['Original range: [', num2str(min(imgIn(:))), ', ', num2str(max(imgIn(:))), ']'])

% Exercise 2a
if a==1
    stretched = contrastStretch(imgIn, minOut, maxOut);
    figure()
    imshow(stretched);
    title(['Stretched: [', num2str(min(stretched(:))), ', ', num2str(max(stretched(:))), ']'])
end

% Exercise 2b
if b==1
    equalized = histogramEqualization(imgIn, minOut, maxOut);
    figure()
    imshow(equalized);
    title(['Equalized: [', num2str(min(equalized(:))), ', ', num2str(max(equalized(:))), ']'])
end
% Exercise 2c