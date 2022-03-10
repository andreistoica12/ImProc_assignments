function imgOut = thresholdImage(th, imgIn, lt, geq)
imgIn(imgIn < th) = lt;
imgIn(imgIn >= th) = geq;
imgOut = imgIn;
end

