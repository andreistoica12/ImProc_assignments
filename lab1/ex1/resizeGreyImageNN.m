function imageOut = resizeGreyImageNN(imageIn, sX, sY)
    [H, W] = size(imageIn);
    new_H = floor(sX * H);
    new_W = floor(sY * W);
    
    imageOut = zeros(new_H, new_W);
    for c1 = 0:new_H - 1
        for c2 = 0:new_W - 1
            imageOut(c1+1, c2+1) = imageIn(1 + floor(c1/sX), 1 + floor(c2/sY));
        end
    end
    imageOut = uint8(imageOut);
end