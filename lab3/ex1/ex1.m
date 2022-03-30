clear all;
n=2;

D0=60;


  img = imread("..\..\images\characters.pgm");
  %figure(); imshow(img);
  [M, N]= size(img);
  P=2*M; Q=2*N;
  H=highPassButterworthFilter(D0, n, P,Q);
  out = convolutionFilter(img, H);
  figure(); imshow(out);
 
 
