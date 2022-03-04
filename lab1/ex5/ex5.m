clear all; 

sqSE = imread('sqSE.pgm'); % square SE
toDilate = imread('toDilate.pgm'); % example from the slides
%toDilate1 = imread('toDilate1.pgm'); % example from the slides
emptyOrSE = imread('emptyOrSE.pgm'); % SE with empty origin [1,0,1]
SE = imread('SE.pgm'); % SE from the slides [1,1]
toErode = imread('toErode.pgm');

dilated = dilateImg(toDilate, SE, [1,1]);
%dilated1 = dilateImg(toDilate1, emptyOrSE, [1, 2]);
eroded = erodeImg(toErode, SE, [1,1]);
%figure();imshow(toDilate);
%figure();imshow(dilated);
%figure();imshow(dilated1);
%figure();imshow(eroded);




function dilated = dilateImg(img, SE, origin)
    [h, w] = size(SE);
    [B, r, c] = reflect(SE, origin(1), origin(2));
    padded = pad(img, h, w, r, c, 0);
    dilated = dilate(padded, B, r, c);
    dilated = dilated(r:r+size(img,1)-1, c:c+size(img,2)-1); % 'unpad'
end

function eroded = erodeImg(img, SE, origin) % use dual property
    [h, w] = size(SE);
    img(:) = ~img; % take a complement
    r = origin(1);
    c = origin(2);
    padded = pad(img, h, w, r, c, 1);
    eroded = dilate(padded, SE, r, c); 
    eroded = eroded(r:r+size(img,1)-1, c:c+size(img,2)-1);
    eroded(:) = ~eroded; 
end

function J = dilate(I, A, r, c)
[h, w] = size(A);
    J = zeros(size(I));
    for i=1:size(I,1)-h+1 % slide SE over the padded image
        for j=1:size(I,2)-w+1
            if sum(A & I(i:i+h-1, j:j+w-1), 'all') > 0 % SE 'hits'
                J(i+r-1, j+c-1) = 1;
            end
        end
    end
end


function P = pad(I, h, w, r, c, v)
    P = padarray(I, [h-r, w-c ],v, 'post'); 
    P = padarray(P, [r-1, c-1], v,'pre'); 
end

function [B, r, c] = reflect(A, r, c)
 B = rot90(A, 2); % rotate 180 degrees == reflection
 r = size(A,1) + 1 - r; % new x-coord of origin
 c = size(A,2) +1 - c; % new y-coord of origin
end