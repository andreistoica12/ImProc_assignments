clear all;

a=1;
b=0;
c=0;
d=0;


% Exercise 1a
if a==1
img = imread("../../images/lena.pgm");
img = thresholdImage(100, img, 0, 255);
imshow(img);
end

% Exercise 1b
if b==1
    epsilon = 0.1;
    th = iterativeThreshold(img, epsilon);
end

% Exercise 1c
if c==1
    th = otsuThreshold(img);
end
% Exercise 1d
if d==1
    
    names = ["vasalis", "dice", "lena", "cameraman", "peppers", "grain", "bacteria" ];
    ths = [32,64,128,192];
    tuples = zeros(size(names,2), size(ths,2));
     for i=1:size(names,2)
         img = imread(strcat("../../images/", names(i),".pgm"));
         for t=1:size(ths,2)
         out = thresholdImage(ths(t), img, 0, 255);
         foreground = size(find(out(:) == 255),1);
         %imwrite(out, strcat("out/", names(i), "_", num2str(ths(t)), "_", num2str(foreground), ".png"));
         tuples(i, t) = foreground; 
         end
     end
     epsilon = 0.1;
     tuples2 = zeros(size(names,2), 4);
    for i=1:size(names,2)
        img = imread(strcat("images/", names(i),".pgm"));
        th = iterativeThreshold(img, epsilon);
        out = thresholdImage(th, img, 0, 255);
        foreground = size(find(out(:) == 255),1);
        tuples2(i, 1) = th;
        tuples2(i, 2) = foreground;
        %imwrite(out, strcat("out/", names(i), "_", "iter_", num2str(th), "_", num2str(foreground), ".png"));
        th = otsuThreshold(img);
        out = thresholdImage(th, img, 0, 255);
        foreground = size(find(out(:) == 255),1);
        tuples2(i, 3) = th;
        tuples2(i, 4) = foreground;
        %imwrite(out, strcat("out/", names(i), "_", "otsu_", num2str(th), "_", num2str(foreground), ".png"));
    end
end




