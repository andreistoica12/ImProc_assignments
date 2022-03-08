close all; % close open figure windows
clear all; % remove items from workspace

a = 1;
b = 1;
c = 1;

imname='images\peppers'; % name of the input image
L = 256;
minOut = 0;
maxOut = L-1;

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
    min(equalized(:))
    max(equalized(:))
    figure()
    imshow(equalized);
    title(['Equalized: [', num2str(min(equalized(:))), ', ', num2str(max(equalized(:))), ']'])
end
% Exercise 2c
if a==1 && b==1 && c==1
     figure()
     origHist = histcounts(imgIn(:), [0:L]);
     bar(origHist);
     title('Original');
     figure()
     stretchedHist =  histcounts(stretched(:), [0:L]);
     bar(stretchedHist);
     title('Contrast Stretching');
     figure()
     equalizedHist =  histcounts(equalized(:), [0:L]);
     bar(equalizedHist);
     title('Histogram Equalization');
end