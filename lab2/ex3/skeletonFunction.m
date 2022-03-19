function skeleton = skeletonFunction(connectivity, img)
    assert(connectivity == 4 || connectivity == 8, "Connectivity should be either 4 or 8!");

%     if connectivity == 8
%         B = strel("square", 3);
%     else
%         B = strel("diamond", 1);
%     end

    [H, W] = size(img);

    skeleton = zeros(H, W, 'uint8');
    n = uint8(0);
    X = logical(img);

%     we execute the following loop as long as we have at least a
%     foreground pixel present in the n-times eroded image
    while any(X, 'all')
        X_prime = logical(erosionNfold(1, connectivity, X));
%         X_prime = logical(imerode(X, B));
        S = X - logical(dilationNfold(1, connectivity, X_prime));
%         S = X - logical(imdilate(X_prime, B));
        skeleton(S == true) = n+1;
        X = X_prime;
        n = n + 1;
    end   
end