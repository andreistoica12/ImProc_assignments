img = imread("../../images/sudoku1.ppm");

img = intensityFromRGB(img); % convert to grayscale 
level = otsuThreshold(img);  % find suitable threshold
img = thresholdImage(level,img, 0,1); % binarize image
bw = double(img); % copy original binary image
SE = ones(2,2);

img = erodeImg(img,SE, [2,2]); % erode image to obtain more prominent lines that split sudoku boxes

% Find connected components (all)
CC = bwconncomp(img);
numOfPixels = cellfun(@numel,CC.PixelIdxList);
[~,indexOfMax] = max(numOfPixels); % max CC corresponds to page "border"
sudokuBox = zeros(size(img));
sudokuBox(CC.PixelIdxList{indexOfMax}) = 1; % extract only page "border"

digits = zeros(size(img)); % will contain all sudoku digits
emptyBoxes = zeros(size(img));  % will contain all empty sudoku boxes
   
sudoku = bw-sudokuBox; % get only sudoku boxes
sudoku=erodeImg(sudoku,SE, [2,2]); % erode to get rid of residual lines
   
for box=1:81 % consider each small box as a CC on its own
   CC.PixelIdxList{indexOfMax}=0; % update current max, as boxes should occupy most space
   numOfPixels = cellfun(@numel,CC.PixelIdxList);
   [~,indexOfMax] = max(numOfPixels); % find new CC (box) that occupies largest area
   sudokuBox = zeros(size(img));
   sudokuBox(CC.PixelIdxList{indexOfMax}) = 1; % box itself
   
   digitCC = bwconncomp(~sudokuBox); % invert and find the digit as CC
   numOfPixelsD = cellfun(@numel,digitCC.PixelIdxList);
   digit = zeros(size(img));
   digit(digitCC.PixelIdxList{1}) = 0; % set background to 0
 
 if  digitCC.NumObjects > 1  % means non-empty box
     digit(digitCC.PixelIdxList{2}) = 1; % digit
     digit = digit-sudoku; % bring back holes of digits
     digits = digits+digit; % add digit to an image containing only digits
 else % empty box
      digit(digitCC.PixelIdxList{1}) = 0; 
      sudokuBox(CC.PixelIdxList{indexOfMax})=1;
      emptyBoxes = emptyBoxes+sudokuBox; % add box to an image containing only boxes 
 end

end

digits(digits <= 0) = 0;
digits(digits > 0) = 1;
emptyBoxes(emptyBoxes <= 0) = 0;
emptyBoxes(emptyBoxes > 0) = 1;

figure(); imshow(digits);
figure(); imshow(emptyBoxes);
figure(); imshow(digits + emptyBoxes);
  

 
 
 %%%%%%%%%%%%%% From previous lab
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
 

