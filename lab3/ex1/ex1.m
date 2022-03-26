clear all;
n=2;

D0=60;
% M=10;N=10;
% img = randi(255, M,N);

  img = imread("..\..\images\characters.pgm");
  [M, N]= size(img);
  
  H=highPassButterworthFilter(D0, n, M,N);



out = convolutionFilter(img, H);
figure(); imshow(out);