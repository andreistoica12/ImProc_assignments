function g = convolutionFilter(img, H)
 if size(H) ~= 2*size(img)
     error("Error. Size of H must be 2x size of the image.");
 end
  img = double(img);
  H = double(H);
  [M, N]= size(img);
  P=2*M; Q=2*N;
  
  imgPadded=zeros(P,Q);                 % pad the image
  imgPadded(1:M, 1:N) = img;
  imgPadded = shift(imgPadded, M,N);    % center the image
  
  F = fft2(imgPadded);                  % frequency domain representation
  G = F .* H;                           % convolution in frequency domain
  
  g = real(ifft2(G));                   % return to spatial domain
  g = shift(g, M,N);                    % uncenter the image
  g = g(1:M, 1:N);                      % extract the original image
 
  g=uint8(g);
  
  function f = shift(f, M, N)           % helper to (un)center the image
  for i=0:(M-1)
      for j=0:(N-1)
          f(i+1, j+1)=  f(i+1, j+1) * (-1)^(i+j);
      end
   end
  end
end

