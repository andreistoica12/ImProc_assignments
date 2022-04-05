clear all;

img = imread("..\..\images\characters.pgm");

% exercise 1a
[centeredSpectrum, greyScaleCenteredSpectrum] = centeredFourierSpectrum(img);
figure(); imshow(greyScaleCenteredSpectrum);
title("Centred Fourier spectrum of characters.pgm");

% exercise 1b - the previous centered Fourier spectrum to which we apply the
% log and exponential transformations
[logSpectrum, greyScaleLogSpectrum] = logFourierSpectrum(centeredSpectrum);
figure(); imshow(greyScaleLogSpectrum);
title({'Log transformation applied to the';'centered Fourier spectrum for characters.pgm'})

expSpectrum = expFourierSpectrum(logSpectrum);
figure(); imshow(expSpectrum);
title({'Exponential transformation applied to the';'log Fourier spectrum for characters.pgm'})

% exercise 1c
imgd = double(img);
ft = fft2(imgd);
conjugate = conj(ft);
conjugate(1,1) = 0;
ift = ifft2(conjugate);
result = uint8(ift);
figure(); imshow(result);
title('Result 1c')


% exercise 1f
n=2;
D0=60;
[M, N]= size(img);
P=2*M; Q=2*N;
H=highPassButterworthFilter(D0, n, P,Q);
out = convolutionFilter(img, H);
figure(); imshow(out);
 
 
