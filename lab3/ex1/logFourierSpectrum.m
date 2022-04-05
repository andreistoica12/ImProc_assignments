function [log_spectrum, greyScaleLogSpectrum] = logFourierSpectrum(spectrum)

    [H, W] = size(spectrum);
    spectrum = double(spectrum);

    log_spectrum = zeros(H, W, 'double');

    % Log transformation
    for i=1:H
        for j=1:W
            formula_term = double(1 + spectrum(i,j));
            log_spectrum(i,j) = log2(formula_term);
        end
    end

    % conversion to grey scale (8-bit)
    greyScaleLogSpectrum = uint8(log_spectrum/(max(log_spectrum(:))) * 255);
end

