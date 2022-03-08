clear all;
img = imread('images\emmius.pgm');
img=uint8(img);
c = deltaComponents(img, 4, 80);
imshow(uint8(c));

function dComponents = deltaComponents(imageIn, connectivity, delta)
img = pad(imageIn, size(imageIn,1), size(imageIn,2),0);
dComponents = zeros(size(img));
N = ones(3,3) ; % neighborhood
if connectivity == 4
    N(1,1) = 0;
    N(3,3) = 0;
    N(1,3) = 0;
    N(3,1) = 0;
end
label1=0;
label2=255;
for i=1:size(img,1)-2 
        for j=1:size(img,2)-2
            p = img(i,j)*N; 
            diff = abs(img(i:i+2, j:j+2)-p); % subtract p from each neighbor
            diff(diff <= delta) = label1; % find neighbors that satisfy the requirements
            diff(diff > delta) = label2;
            dComponents(i:i+2, j:j+2) = diff; 
        end
end
    dComponents = dComponents(2:end-1, 2:end-1);
end

function P = pad(I, h, w, v)
    P = v * ones(h+2, w+2);
    P(2:h+1, 2:w+1) = I;
end