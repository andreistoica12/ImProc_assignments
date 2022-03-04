clear all; 
As = [1,1,1;1,1,1;1,1,1];
A1 = [1,0,0;1,2,0;1,0,0];
A2 = [1,1,1,2,0,1,1];
A3 = [0,0,0,1,0,0,0; 0,0, 1,1,1,0,0;0,1,2,1,1,1,0;0,1,1,1,1,1,0; 0,1,1,1,1,1,0;0,0, 1,1,1,0,-1;0,0,0,1,0,-1,0];

I = zeros(5,4);
I(1, 2)= 1;
I(2, 2)= 1;
I(3, 2)= 1;
I(3, 3)= 1;
I(4, 1) = 1;
%figure; imshow(I);


j = dilateImg(I, As, [2, 2]);
i = [0,1,0;0,1,0;0,1,0];
a = [1,0,1];
j = dilateImg(i,a,[1,2])

function dilated = dilateImg(img, SE, origin)
    [h, w] = size(SE);
    [B, oX, oY] = reflect(SE, origin(1), origin(2));
    padded = pad(img, h, w, oX, oY);
    dilated = dilate(padded, B, oX, oY);
    dilated = dilated(oX:oX+size(img,1)-1, oY:oY+size(img,2)-1);
end

function J = dilate(I, A, oX, oY)
[h, w] = size(A);
    J = zeros(size(I));
    for i=1:size(I,1)-h+1
        for j=1:size(I,2)-w+1
            if sum(A & I(i:i+h-1, j:j+w-1), 'all') > 0
                J(i+oX-1, j+oY-1) = 1;
            end
        end
    end
end



function P = pad(I, h, w, oX, oY)
    P = padarray(I, [h-oX, w-oY ], 'post'); % adds cols to the right
    P = padarray(P, [oX-1, oY-1], 'pre'); % adds cols to the left
  
end

function [B, oX, oY] = reflect(A, oX, oY)
 B = rot90(A, 2); % rotate 180 degrees == reflection
 oX = size(A,1) + 1 - oX; % new x-coord of origin
 oY = size(A,2) +1 - oY; % new y-coord of origin
end