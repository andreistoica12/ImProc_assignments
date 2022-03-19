clear all;

imgc = imread("images/poppies.ppm");
k=4;

[out, l]  =q(imgc,k,1);

unique(l)
imshow(out);

function [pixelLabels, minDist] = cluster(img, means, k, method, minDist, pixelLabels)
img = double(img);
    for mean = 1:k
        if method == 1
         kmean = repmat(double(means(mean,:)), size(img,1),1);
         ds = sqrt(sum((img-kmean).^2,2));
         %ds = sum(abs(img-kmean),2);
        end
         pixelLabels(minDist > ds) = mean;
         minDist(minDist > ds) = ds(ds < minDist);
    end
end

function means = updateMeans(pixelLabels, img, k)
means = zeros(k,3);
for clusterLabel=1:k
   means(clusterLabel,:) = mean(img(pixelLabels==clusterLabel,:),1); 
end
end

function [imgOut, pixelLabels] = q(imageIn, k, method)
[H, W, c] = size(imageIn);
reshapedImg = reshape(imageIn, [H*W,c]);
R = reshapedImg(:,1); 
G = reshapedImg(:,2); 
B = reshapedImg(:,3);
RGB = [R, G, B]; % rows = pixels, cols = channels
randPixels = randi([1 H*W], [1 k]); % indices of random pixels
means = RGB(randPixels, :); % centroids 
pixelLabels = zeros(H*W,1);
minDist = 255*ones(H*W, 1);
for iter=1:20
     [pixelLabels, minDist] = cluster(reshapedImg, means, k, method, minDist, pixelLabels);
     means = updateMeans(pixelLabels, reshapedImg, k);
end

for cl=1:k
    reshapedImg(pixelLabels==cl,:) = repmat(means(cl, :), sum(pixelLabels == cl), 1); 
end
imgOut = (reshape(reshapedImg, [H,W,c]));
end

