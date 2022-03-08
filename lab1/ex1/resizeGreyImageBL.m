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

%     with the operations below, we make sure we map each pixel in the
%     output image correctly, i.e. if we have valid scaling factors,
%     positions of pixels in the image at 0.5 + scaling factor in the ouput
%     map to 0.5 + 1 (=1.5) in the input
    for i = 1:new_H
        r = (h_ratio * i) + (0.5 * (1 - 1/sR));
        for j = 1:new_W
            c = (w_ratio * j) + (0.5 * (1 - 1/sC));

%             all column values lower than 1 are capped at 1
%             all column values larger than a value just under W is capped
%             at that value, as we then apply the floor() function to
%             obtain a maximum value for c1 equal to W-1 and a maximum
%             value for c2 equal to W. This way, we do not reach out of
%             bound points
            c(c < 1) = 1;
            c(c > W - 0.001) = W - 0.001;
            c1 = floor(c);
            c2 = c1 + 1;
            
%             similar to column indices
            r(r < 1) = 1;
            r(r > H - 0.001) = H - 0.001;
            r1 = floor(r);
            r2 = r1 + 1;
            
%             the intensity values of the 4 neighbouring pixels, which form
%             a rectangle around the 
%             pixel we want to assign a grey value to. We use the same
%             notation as in the lecture slides.
            Sx0 = imageIn(r2,c1); 
            Sx1 = imageIn(r2,c2);
            Sx2 = imageIn(r1,c1);
            Sx3 = imageIn(r1,c2);

%             coefficients for the weighted average over the 4 neighbors
            coeff0 = (c2-c)*(r-r1);     % = (1-aplha)(1-beta)
            coeff1 = (r-r1)*(c-c1);     % = alpha(1-beta)
            coeff2 = (r2-r)*(c2-c);     % = (1-alpha)beta
            coeff3 = (r2-r)*(c-c1);     % = alpha*beta

%             formula in the slides: Sx = (1-alpha)(1-beta) * Sx0 + alpha(1 -
%             beta) * Sx1 + (1 - alpha)beta * Sx2 + alpha*beta * Sx3
            imageOut(i,j) = coeff0 * Sx0 + coeff1 * Sx1 + coeff2 * Sx2 + coeff3 * Sx3;

            imageOut = uint8(imageOut);
        end
    end


end