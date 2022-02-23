function [imgOut, h, P] = histogramEqualization(imgIn, minOut, maxOut)
    imgIn = double(imgIn); 
    [height, width] = size(imgIn);
    N = height * width;
    minIn = min(imgIn(:));
    maxIn = max(imgIn(:)); % == (L-1)
    h = hist(imgIn(:), maxIn-minIn); % row vec, orig image
    
    P = maxIn * 1/N * cumsum(h); 
    P =  uint8(P);
    
    imgOut = zeros(height, width);
    
end

