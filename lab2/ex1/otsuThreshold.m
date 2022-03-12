function th = otsuThreshold(imgIn)
N = size(imgIn, 1) * size(imgIn, 2);
h = histcounts(imgIn(:), [0:256]);
p = h/N;    % normalized histogram
muGlobal = sum([0:255] .* p);  % global mean
varGlobal = sum( ([0:255] - muGlobal) .* ([0:255] - muGlobal) .* p);
etas = zeros(1, 256);
for k=1:256
    p1 = sum(p(1:k));
    p2 = sum(p(k+1:end));
    mu1 = 1/p1 * sum([0:k-1] .* p(1:k));
    mu2 = 1/p2 * sum([k:255] .* p(k+1:end));
    varB = p1 * p2 * (mu1 - mu2)^2;
    eta = varB/varGlobal;
    etas(k) = eta;
end
maxEta = max(etas);
th = find(etas==maxEta, 1)-1;
end

