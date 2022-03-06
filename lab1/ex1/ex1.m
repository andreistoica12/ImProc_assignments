close all; % close open figure windows
clear all; % remove items from workspace

imname='../../images/blurrymoon'; % name of the input image
inputfile = [imname,'.pgm'];
im = imread(inputfile); % read input image

imname2='../../images/lena'; % name of the input image
inputfile2 = [imname2,'.pgm'];
im2 = imread(inputfile2); % read input image

% exercise 1a
figure(1)
imshow(im)

resizedImageNN = resizeGreyImageNN(im, 0.7, 1.39);

figure(2)
imshow(resizedImageNN);
title('Resized image, using nearest neighbor interpolation');

% exercise 1b
resizedImageBL = resizeGreyImageBL(im, 0.7, 0.7);

figure(3)
imshow(resizedImageBL);
title('Resized image, using bilinear interpolation');

% resizedImageBLMatlab = imresize(im, 0.7, 'bilinear');
% figure(4)
% imshow(resizedImageBLMatlab);


% test1 = [2564, 653, 754765, 6543, 753; 65468, 74572, 1467, 9532, 125; 3654, 747, 353, 648, 9754];
% test2 = [4245, 6573, 751, 4232, 864; 967, 541, 464, 953, 4627; 537, 235, 654, 5829, 5425];
% 
% MatlabMSE = immse(test1, test2);
% myMSE = MSE(test1, test2);

% exercise 1c
[H_im2, W_im2] = size(im2);
im1testMSE = imresize(im, [H_im2 W_im2]);
im2testMSE = im2;

MatlabMSE = immse(im1testMSE, im2testMSE);
myMSE = MSE(im1testMSE, im2testMSE);
