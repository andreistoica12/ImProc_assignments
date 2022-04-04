function spectrum = centeredFourierSpectrum(img)
    [H, W] = size(img);
    imgd = double(img);

    temp = zeros(H, W, 'double');
    for x = 1:H
        for y = 1:W
            temp(x, y) = (-1)^(x + y) * imgd(x, y);
        end
    end
    

    fft = fft2(temp);
    spectrum = fft;

%     % TODO: need to apply a transformation and map to [0, 255]
%     spectrum = zeros(H, W, 'double');
%     for x = 1:H
%         for y = 1:W
%             spectrum(x, y) = sqrt(real(fft(x, y))^2 + imag(fft(x, y))^2);
%         end
%     end


%     % slow implementation, using formula
%     DFT = zeros(H, W, 'double');
%     omega_H = exp(1) ^ (-2 * pi * 1i / H);
%     omega_W = exp(1) ^ (-2 * pi * 1i / W);
% 
% 
%     for p = 0:H - 1
%         for q = 0:W - 1
%             sum = double(0);
%             for j = 0:H - 1
%                 for k = 0:W - 1
%                     sum = sum + omega_H ^ (j * p) * omega_W ^ (k * q) * temp(j + 1, k + 1);
%                 end
%             end
%             DFT(p+1, q+1) = sum;
%         end
%     end
% 
%     spectrum = DFT;

end

