function imrgbOut = intensityFromRGB(imrgb)
    imrgbOut = uint8(mean(imrgb, 3));
end

