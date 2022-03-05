function imageOut = resizeGreyImageBL(imageIn, sX, sY)
%     we validate the input (both scaling factors need to be positive
%     numbers)
    mustBePositive(sX);
    mustBePositive(sY);
%     we store the initial spacial size of the input
    [H, W] = size(imageIn);
%     we define the dimensions of the new grid (output image)
    new_H = floor(sX * H);
    new_W = floor(sY * W);

%     initialize the output image with zeros
    imageOut = zeros(new_H, new_W);
%     we store the ratios between the old and the new dimensions
    h_ratio = H / new_H;
    w_ratio = W / new_W;

    for i = 1:new_H
        y = (h_ratio * i) + (0.5 * (1 - 1/sY));
        for j = 1:new_W
            x = (w_ratio * j) + (0.5 * (1 - 1/sX));

%             Any values out of acceptable range
            x(x < 1) = 1;
            x(x > H - 0.001) = H - 0.001;
            x1 = floor(x);
            x2 = x1 + 1;

            y(y < 1) = 1;
            y(y > W - 0.001) = W - 0.001;
            y1 = floor(y);
            y2 = y1 + 1;

%             the 4 neighboring pixels
            NP1 = imageIn(y1,x1);
            NP2 = imageIn(y1,x2);
            NP3 = imageIn(y2,x1); 
            NP4 = imageIn(y2,x2);

%             coefficients for the weighted average over the 4 neighbors
            c1 = (y2-y)*(x2-x);
            c2 = (y2-y)*(x-x1);
            c3 = (x2-x)*(y-y1);
            c4 = (y-y1)*(x-x1);

            imageOut(i,j) = c1 * NP1 + c2 * NP2 + c3 * NP3 + c4 * NP4;

            imageOut = uint8(imageOut);
        end
    end


end