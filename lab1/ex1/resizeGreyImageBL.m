function imageOut = resizeGreyImageBL(imageIn, sR, sC)
%     we validate the input (both scaling factors need to be positive
%     numbers)
    mustBePositive(sR);
    mustBePositive(sC);
%     we store the initial spacial size of the input
    [H, W] = size(imageIn);
%     we define the dimensions of the new grid (output image)
    new_H = floor(sR * H);
    new_W = floor(sC * W);

%     initialize the output image with zeros
    imageOut = zeros(new_H, new_W);
%     we store the ratios between the old and the new dimensions
    h_ratio = H / new_H;
    w_ratio = W / new_W;

    for i = 1:new_H
        r = (h_ratio * i) + (0.5 * (1 - 1/sR));
        for j = 1:new_W
            c = (w_ratio * j) + (0.5 * (1 - 1/sC));

%             Any values out of acceptable range
            c(c < 1) = 1;
            c(c > W - 0.001) = W - 0.001;
            c1 = floor(c);
            c2 = c1 + 1;
            

            r(r < 1) = 1;
            r(r > H - 0.001) = H - 0.001;
            r1 = floor(r);
            r2 = r1 + 1;
            
%             the 4 neighboring pixels
            NP1 = imageIn(r1,c1);
            NP2 = imageIn(r1,c2);
            NP3 = imageIn(r2,c1); 
            NP4 = imageIn(r2,c2);

%             coefficients for the weighted average over the 4 neighbors
            co1 = (r2-r)*(c2-c);
            co2 = (r2-r)*(c-c1);
            co3 = (c2-c)*(r-r1);
            co4 = (r-r1)*(c-c1);

            imageOut(i,j) = co1 * NP1 + co2 * NP2 + co3 * NP3 + co4 * NP4;

            imageOut = uint8(imageOut);
        end
    end


end