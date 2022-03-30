function g = convolutionFilter(img, H)
  img=double(img);
  H = double(H);
  [M, N]= size(img);
  P=2*M; Q=2*N;
  
  imgPadded=zeros(P,Q);% pad the image
  imgPadded(1:M, 1:N) = img;
 
  imgPadded = shift(imgPadded, M,N);% center transform
  F = fft2(imgPadded);
  
  G = F .* H;
  g = real(ifft2(G));
  g = shift(g, M,N); % uncenter transform
  g = g(1:M, 1:N);
 
  g=uint8(g);
  function f = shift(f, M, N)
  for i=0:(M-1)
      for j=0:(N-1)
          f(i+1, j+1)=  f(i+1, j+1) * (-1)^(i+j);
      end
   end
  end
end

