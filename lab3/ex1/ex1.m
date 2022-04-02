clear all;

img = imread("..\..\images\characters.pgm");

centeredSpectrumCharacters = centeredFourierSpectrum(img);
figure(); imshow(centeredSpectrumCharacters);
title("Centred spectrum of characters.pgm");

n=2;
D0=60;
[M, N]= size(img);
P=2*M; Q=2*N;
H=highPassButterworthFilter(D0, n, P,Q);
out = convolutionFilter(img, H);
figure(); imshow(out);
 
 
