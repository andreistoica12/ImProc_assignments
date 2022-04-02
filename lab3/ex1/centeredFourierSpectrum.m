function spectrum = centeredFourierSpectrum(img)
    [H, W] = size(img);
    imgd = double(img);

    temp = zeros(H, W, 'double');
    for row = 1:H
        for col = 1:W
            temp(row, col) = (-1)^(row + col) * imgd(row, col);
        end
    end
    
    spectrum = fft2(temp);
end

