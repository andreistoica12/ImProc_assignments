function out = convolutionFilter(img, H)
img = double(img);
H = double(H);
[M, N] = size(img);
[C, D] = size(H);
P = M+C-1;
Q = N+D-1;
P=M;Q=N;

imgPadded = zeros(P, Q); % zero padding
imgPadded(1:M, 1:N) = img; 
Hp = zeros(P, Q);
Hp(1:C, 1:D) = H; % zero padding


F = fft2(imgPadded, P, Q);  % FFT of image
F  = fftshift(F);           % center transform
G = F .* Hp;                % product of FFTs
G = ifftshift(G); 
g = ifft2(G);
g = real(g);        % real part of inverse FFT 
out = g(1:M, 1:N);         % unpad
out = uint8(out);
end

