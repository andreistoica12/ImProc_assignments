function X = reconstructionFromSkeleton(connectivity, skf)
    assert(connectivity == 4 || connectivity == 8, "Connectivity should be either 4 or 8!");
    
    [H, W] = size(skf);

    X = zeros(H, W, "logical");
    set_n = zeros(H, W, "logical");

    for n = 0:length(unique(skf))
        set_n(skf == n+1) = true;
        dilated_set_n = dilationNfold(n, connectivity, set_n);
        X = X | dilated_set_n;
        set_n(:) = false;
    end
end

