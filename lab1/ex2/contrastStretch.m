function imgOut = contrastStretch(imgIn, minOut, maxOut)
    imgIn = double(imgIn);      
    minIn = min(imgIn(:));
    maxIn = max(imgIn(:));
    imgOut = (maxOut-minOut)/(maxIn-minIn) .* (imgIn-minIn);
    imgOut = uint8(imgOut);
end

