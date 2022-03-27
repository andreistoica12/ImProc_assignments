clear all;
n=2;

D0=60;
% M=10;N=10;
% img = randi(255, M,N);

  img = imread("..\..\images\characters.pgm");

img = padarray(img, [10 10],224,'both');
 %figure(); imshow(img);
  [M, N]= size(img);
  img=double(img);
  
  P=2*M; Q=2*N;
  imgPadded=zeros(P,Q);
  imgPadded(1:M, 1:N) = img;
  for i=0:(M-1)
      for j=0:(N-1)
          imgPadded(i+1, j+1)=  imgPadded(i+1, j+1) * (-1)^(i+j);
      end
  end
  F = fft2(imgPadded);
  H=highPassButterworthFilter(D0, n, P,Q);
  G = F .* H;
  
  g = real(ifft2(G));
   for i=0:(M-1)
      for j=0:(N-1)
          g(i+1, j+1)=  g(i+1, j+1) * (-1)^(i+j);
      end
   end
  g = g(1:M, 1:N);
  g=uint8(g);
  imshow(g);
 
%  H=highPassButterworthFilter(D0, n, M,N);
%  
%  out = convolutionFilter(img, H);
%  imshow(out);

