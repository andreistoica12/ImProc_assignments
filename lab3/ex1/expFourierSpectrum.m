function exp_spectrum = expFourierSpectrum(spectrum)
    [H, W] = size(spectrum);
    spectrum = double(spectrum);
    
    % Exponantial transformation
    exp_spectrum = zeros(H, W, 'double');

    for i=1:H
        for j=1:W
            formula_term = double(1 + spectrum(i,j));
            exp_spectrum(i,j) = exp(formula_term);
        end
    end

    exp_spectrum = exp_spectrum/(max(exp_spectrum(:))) * 255;
end

