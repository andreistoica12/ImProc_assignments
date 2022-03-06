clear all; 

a =  0;
b = 0;
c = 0;


sqSE = imread('sqSE.pgm'); % square 3x3 SE 
SE = imread('SE.pgm'); % SE from the slides [1,1]

img1 = imread('images\dice.pgm');
img2=img1;
img1(img1 < 128) = 0;
img1(img1 >= 128) = 255;
imshow(img1);

%%% Ex 5a %%%
if a == 1
 toDilate = imread('toDilate.pgm'); % example from the slides
 dilated = dilateImg(toDilate, SE, [1,1]);
 
 toDilate1 = imread('toDilate1.pgm'); % example from the slides (for empty origin)
 emptyOrSE = imread('emptyOrSE.pgm'); % SE with empty origin [1,0,1]
 dilated1 = dilateImg(toDilate1, emptyOrSE, [1, 2]);
end

%%% Ex 5b %%%
if b == 1
    toErode = imread('toErode.pgm');
    eroded = erodeImg(toErode, SE, [1,1]);
end

% reduced = img(70:end-80,end-200:end-50);
%img = img(40:110,50:250);

%%% Ex 5c %%%
if c==1
img = imread('images\dice.pgm');
img = im2bw(img, 0.5);
%img(img < 128) = 0;
%img(img >= 128) = 255;
img = openImg(img, sqSE, [2,2]);
imshow(img)

[dice, pips] = countDice(img, ones(7,7), ones(7,7));
h = histcounts(pips, [1:10]); 
bar(h);
totalPips = sum(pips);
end



function component = connectedComponent(img, SE)
    component = zeros(size(img));
   [pR, pC] = find(img, 1, 'first'); 
    component(pR, pC) = 1;
    temp = zeros(size(component));
    while ~isequal(temp, component) 
        temp = component;
        component = dilateImg(temp, SE, [ceil(size(SE,1)/2),ceil(size(SE,2)/2)]) & img;
    end
end

function [numOfDice, numOfPips] = countDice(img, diceSE, pipsSE)
    numOfDice = 0; % number of dice
    numOfPips = []; % number of pips per each dice
    allDice = zeros(size(img)); % holder for connected components
    
    while any(img, 'all') % for each dice
        dice =  connectedComponent(img, diceSE);
        allDice = allDice + dice;
        numOfDice = numOfDice +1;
        img = img - dice;
        
        unholeyDice = closeHoles(dice, pipsSE);
        pipsImg = unholeyDice - dice; % only holes should be kept
        
        pips = zeros(size(img));
        pipsPerDice = 0;
        while any(pipsImg, 'all') % for each pip
            pip = connectedComponent(pipsImg, pipsSE);
            pips = pips + pip;
            pipsPerDice = pipsPerDice + 1;
            pipsImg = pipsImg - pip;
        end
         numOfPips = [numOfPips, pipsPerDice];
    end
    
end



function unholey = closeHoles(img, SE)
    mask = ~img;
 
    marker = zeros(size(img,1), size(img,2));   
    marker(1,:) = 1-img(1,:);
    marker(end,:) = 1-img(end,:);
    marker(2:end-1,1) = 1-img(2:end-1,1);
    marker(2:end-1,end) = 1-img(2:end-1,end);
    
    unholey = marker;
    temp = zeros(size(marker));
    while ~isequal(temp, unholey) 
    temp = unholey;
    unholey = dilateImg(temp, SE, [ceil(size(SE,1)/2),ceil(size(SE,2)/2)]) & mask;
    end
    unholey(:)=~unholey;
end


function opened = openImg(img, SE, origin)
    opened = dilateImg(erodeImg(img, SE, origin), SE, origin);
end


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
    P = v * ones(h-1+size(I,1), w-1+size(I,2));
    P(r:size(I,1)+r-1, c:size(I,2)+c-1) = I;
end

function [B, r, c] = reflect(A, r, c)
 B = rot90(A, 2); % rotate 180 degrees == reflection
 r = size(A,1) + 1 - r; % new x-coord of origin
 c = size(A,2) +1 - c; % new y-coord of origin
end