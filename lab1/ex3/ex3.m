close all; % close open figure windows
clear all; % remove items from workspace

imname='../../images/peppers'; % name of the input image
inputfile = [imname,'.pgm'];
im = imread(inputfile); % read input image

figure(1)
imshow(im)

[quantizedImage_k3, means_k3, means_matrix_k3, initial_means_k3, clusters_k3, current_positions_k3, label_matrix_k3] = quantization(im, 3);
figure(2)
imshow(quantizedImage_k3);
title("Quantized image for k = 3")

[quantizedImage_k10, means_k10, means_matrix_k10, initial_means_k10, clusters_k10, current_positions_k10, label_matrix_k10] = quantization(im, 10);
figure(3)
imshow(quantizedImage_k10);
title("Quantized image for k = 10")
