function imgOut = contrastStretch(imgIn, minOut, maxOut)
    imgIn = double(imgIn);      
    minIn = min(imgIn(:));
    maxIn = max(imgIn(:));
    imgOut = (imgIn - minIn) .* (maxOut-minOut)/(maxIn-minIn) + minOut;
    imgOut = uint8(imgOut);
end

