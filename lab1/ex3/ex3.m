close all; % close open figure windows
clear all; % remove items from workspace

imname='../../images/peppers'; % name of the input image
inputfile = [imname,'.pgm'];
im = imread(inputfile); % read input image

figure(1)
imshow(im)

[quantizedImage, means, clusters, current_positions, label_matrix] = quantization(im, 10);
figure(2)
imshow(quantizedImage);
title("Quatized image, with k = 10 clusters");
