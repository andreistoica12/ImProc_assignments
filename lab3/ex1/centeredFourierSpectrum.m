function [spectrum, greyScaleSpectrum] = centeredFourierSpectrum(img)
    [H, W] = size(img);
    imgd = double(img);

    % in order to compute the centered Fourier spectrum, we need to first
    % multiply each pixel of the image by (-1)^(x+y)
    temp = zeros(H, W, 'double');
    for x = 1:H
        for y = 1:W
            temp(x, y) = (-1)^(x + y) * imgd(x, y);
        end
    end
    

    fft = fft2(temp);

    % the Fourier spectrum computed after the formula : square root of the
    % sum of the real part raised to the power of 2 and the imaginary part
    % raised to the power of 2
    spectrum = zeros(H, W, 'double');
    for x = 1:H
        for y = 1:W
            spectrum(x, y) = sqrt(real(fft(x, y))^2 + imag(fft(x, y))^2);
        end
    end


    greyScaleSpectrum = spectrum/(max(spectrum(:))) * 255;


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

