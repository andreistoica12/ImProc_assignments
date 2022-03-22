clear all;
b = 1;

% Exercise 1b
if b==1
 names = ["colourflower", "peppers", "poppies", "roses"];
 ks = [1, 2, 4, 5, 6, 8, 10, 20, 30, 50, 100];

 for i=1:size(names,2)
         img = imread(strcat("../../images/", names(i),".ppm"));
         for metric=1:3
             for k=1:size(ks,2)
         [out, ~, iters] = kMeansRgb(img, ks(k), metric);
         
         imwrite(out, strcat("out/",num2str(metric), "_", names(i), "_k=", num2str(ks(k)), "_iters=", num2str(iters), ".png"));
        
             end
         end
 end
end

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
pixelLabels = ones(H*W,1);
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

