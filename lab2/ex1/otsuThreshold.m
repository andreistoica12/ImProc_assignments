function th = otsuThreshold(imgIn)
N = size(imgIn, 1) * size(imgIn, 2);
h = histcounts(imgIn(:), [0:256]);
p = h/N;    % normalized histogram
muGlobal = sum([0:255] .* p);  % global mean
varGlobal = sum(([0:255] - muGlobal) .* ([0:255] - muGlobal) .* p);

p1 = cumsum(p); % probabilities as cumulative sums
p2 = 1-cumsum(p);
s1 = cumsum(p .* [0:255]);
s2 = s1(end)-s1;
mu1 = s1 ./ p1; % mean class intensities
mu2 = s2 ./ p2;
varB = p1 .* p2 .* (mu1-mu2).^2; % between-class variance
etas = varB/varGlobal; % measure of effectiveness

maxEta = max(etas); 
allmax = find(etas==maxEta) - 1; % account for indexing from 1;
th = uint8(mean(allmax));   % average multiple thresholds resulting in best separability
end