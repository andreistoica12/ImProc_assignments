clear all;

img = imread("..\..\images\plant.pgm");
[M, N] = size(img);

sigma=5;
J=3;
pyr = pyramidDecomposition(img,J,sigma);
imshow(uint8(pyr));
 

function pyr=pyramidDecomposition(img,J,sigma)
img = double(img);
[M, ~] = size(img);
exponents = [0:J-1];
bases = 0.5 * ones(1, J);
P = M * sum(bases .^ exponents);
pyr = zeros (P, M);
r=1;c=1;
fj = img;
for level=1:J
    if level > 1 
         fj = reduce(fj, sigma);
    end
    if level < J
        dj =  fj - expand(reduce(fj, sigma), sigma);
        pyr(r:r+size(dj,1)-1, c:c+size(dj,2)-1) = dj;
        r = r + size(dj,1); c = c+size(dj,2)/4;
    end 
end
pyr(r:r+size(fj,1)-1, c:c+size(dj,2)/2-1) = fj;
end

function f = reduce(f, sigma)
% Gaussian filtering followed by downsampling
[M, N] = size(f);
H = gaussian(sigma, M, N );
f = convolutionFilter(f, H);
f = downsampleX2(f);
end

function f = expand(f, sigma)
% upsampling followed by Gaussian filtering
f = upsampleX2(f);
[M, N] = size(f);
H = gaussian(sigma, M, N );
f = convolutionFilter(f, H);
end


function f = downsampleX2(f)
f = f(1:2:end, 1:2:end); % take only odd rows/cols
end

function f = upsampleX2(f)
temp = zeros(2*size(f));
temp(1:2:end, 1:2:end) = f;
f = temp;
end

function H = gaussian(D0,M,N)
% Returns centered at (M/2, N/2) kernel
rfloor = floor(M/2); rceil = ceil(M/2); % midpoint along rows
cfloor = floor(N/2); cceil = ceil(N/2); % midpoint along columns
u = -rfloor:rceil-1; % centered vector along rows
v = -cfloor:cceil-1; % centered vector along columns
[V,U] = meshgrid(v,u); % mesh of size M x N
D = ((U).^2 + (V).^2);
H =  exp(-(D) ./(2*D0^2));
end

function g = convolutionFilter(img, H)
  img = double(img);
  H = double(H);
  [M, N]= size(img);
  img = shift(img, M,N);    % center the image
  F = fft2(img);                  % frequency domain representation
  G = F .* H;                           % convolution in frequency domain
  g = real(ifft2(G));                   % return to spatial domain
  g = shift(g, M,N);                    % uncenter the image

  function f = shift(f, M, N)           % helper to (un)center the image
  for i=0:(M-1)
      for j=0:(N-1)
          f(i+1, j+1)=  f(i+1, j+1) * (-1)^(i+j);
      end
   end
  end
end