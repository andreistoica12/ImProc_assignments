clear all;

imgc = imread("images/poppies.ppm");
k=6;

[out, l, iters]  = kMeansRgb(imgc,k,1);
labels = unique(l);
imshow(out);

function pixelLabels = cluster(img, means, k, metric, minDist, pixelLabels)
    for clusterLabel = 1:k
        % repeat current mean to perform matrix operation and obtain
        % distances for all pixels at the same time
         kmean = repmat(means(clusterLabel,:), size(img,1),1);
         ds = distance(img, kmean, metric);
         % update labels of pixels if new distance is smaller
         pixelLabels(minDist >= ds) = clusterLabel;
         % update current minimal distance
         minDist(minDist >= ds) = ds(ds <= minDist);
    end
end

function ds = distance(p, q, metric) % p, q are matrices
p = double(p);
q = double(q);
if metric == 1 % Euclidean
    ds = sqrt(sum((p-q).^2,2));
elseif metric == 2 % Cityblock
    ds = sum(abs(p-q),2);
elseif metric == 3 % Chessboard
    ds = max(abs(p-q), [], 2);
end
end

function means = updateMeans(pixelLabels, img, k)
means = zeros(k,3);
for clusterLabel=1:k
   means(clusterLabel,:) = mean(img(pixelLabels==clusterLabel,:),1); 
end
end

function [imgOut, pixelLabels, iter] = kMeansRgb(imageIn, k, metric)
[H, W, c] = size(imageIn);
% flatten such that rows = pixels, cols = channels
reshapedImg = reshape(imageIn, [H*W,c]); 
randPixels = randi([1 H*W], [1 k]);         % indices of random pixels
means = reshapedImg(randPixels, :);         % centroids 
pixelLabels = zeros(H*W,1);
minDist = 255*ones(H*W, 1);

for iter=1:100
    % label each pixel with cluster number
     pixelLabels = cluster(reshapedImg, means, k, metric, minDist, pixelLabels);
     prevMeans = means;
    % recompute new means based on pixel values of each cluster
     means = updateMeans(pixelLabels, reshapedImg, k);
      if all(distance(means, prevMeans, metric) < 1)
          break
      end
end

% assign mean colors to clusters 
for clusterLabel=1:k
    reshapedImg(pixelLabels==clusterLabel,:) = repmat(means(clusterLabel, :), sum(pixelLabels == clusterLabel), 1); 
end

% reshape image back to 3D
imgOut = (reshape(reshapedImg, [H,W,c]));
end

