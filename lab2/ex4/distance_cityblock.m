function ds = distance_cityblock(p, q) % p, q are matrices
    p = double(p);
    q = double(q);
    ds = sum(abs(p-q),2);
end

