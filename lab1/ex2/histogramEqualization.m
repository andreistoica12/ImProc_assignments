function imgOut = histogramEqualization(imgIn, minOut, maxOut)
    L = 256;
    [height, width] = size(imgIn);
    N = height * width;
    h = histcounts(imgIn(:), [0:L]);    % freq of values in possible range
    cdf = cumsum(h)/N;                  % normalized cumulative frequency
    P = (L-1)*cdf;
    % normalize for the given range
    minIn = min(P);
    maxIn = max(P);
    P = minOut + (maxOut - minOut) * (P - minIn)/(maxIn-minIn);
    P = uint8(P);
    imgOut = intlut(imgIn, P);           % map
end

