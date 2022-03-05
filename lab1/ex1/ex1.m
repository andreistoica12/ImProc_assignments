close all; % close open figure windows
clear all; % remove items from workspace

imname='../../images/blurrymoon'; % name of the input image
inputfile = [imname,'.pgm'];
im = imread(inputfile); % read input image

figure(1)
imshow(im)

resizedImage = resizeGreyImageNN(im, 0.7, 1.39);

figure(2)
imshow(resizedImage);
title('Resized image, using nearest neighbor interpolation');

resizedImageBL = resizeGreyImageBL(im, 0.7, 0.7);

figure(3)
imshow(resizedImageBL);
title('Resized image, using bilinear interpolation');

resizedImageBLMatlab = imresize(im, 0.7, 'bilinear');
figure(4)
imshow(resizedImageBLMatlab);