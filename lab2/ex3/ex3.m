clear all;
img1 = imread("../../images/horse.pgm");
img2 = imread("../../images/nutsbolts.pgm");
% figure(); imshow(img1);
% title('horse.pgm - image 1');
% figure(); imshow(img2);
% title('nutsbolts.pgm - image 2');

%% 3a - computing the 4-connectivity and 8-connectivity skeletons
%% and rendering the image based on the skeleton function defined
%% in the assignment body.
skeleton_4_img1 = skeletonFunction(4, img1);
figure(); imshow(skeleton_4_img1);
title("Skeleton of image 1 - 4 connectivity");
unique_sets_4_img1 = unique(skeleton_4_img1);

skeleton_8_img1 = skeletonFunction(8, img1);
figure(); imshow(skeleton_8_img1);
title("Skeleton of image 1 - 8 connectivity");
unique_sets_8_img1 = unique(skeleton_8_img1);

skeleton_4_img2 = skeletonFunction(4, img2);
figure(); imshow(skeleton_4_img2);
title("Skeleton of image 2 - 4 connectivity");
unique_sets_4_img2 = unique(skeleton_4_img2);

skeleton_8_img2 = skeletonFunction(8, img2);
figure(); imshow(skeleton_8_img2);
title("Skeleton of image 2 - 8 connectivity");
unique_sets_8_img2 = unique(skeleton_8_img2);

%% 3b - reconstructing of the binary image X from the skeleton
%% obtained at 3a (a grayscale image)
reconstructedFromSkeleton_4_img1 = reconstructionFromSkeleton(4, skeleton_4_img1);
figure(); imshow(reconstructedFromSkeleton_4_img1);
title("Reconstruction of image 1 - 4 connectivity");

reconstructedFromSkeleton_8_img1 = reconstructionFromSkeleton(8, skeleton_8_img1);
figure(); imshow(reconstructedFromSkeleton_8_img1);
title("Reconstruction of image 1 - 8 connectivity");

reconstructedFromSkeleton_4_img2 = reconstructionFromSkeleton(4, skeleton_4_img2);
figure(); imshow(reconstructedFromSkeleton_4_img2);
title("Reconstruction of image 2 - 4 connectivity");

reconstructedFromSkeleton_8_img2 = reconstructionFromSkeleton(8, skeleton_8_img2);
figure(); imshow(reconstructedFromSkeleton_8_img2);
title("Reconstruction of image 2 - 8 connectivity");

%% 3c - demonstrating the reconstructed images equal the original ones
fprintf("Reconstruction of image 1 (4-connectivity) is the same as the original: %s\n", ...
    mat2str(isequal(imbinarize(img1), reconstructedFromSkeleton_4_img1)));

fprintf("Reconstruction of image 1 (8-connectivity) is the same as the original: %s\n", ...
    mat2str(isequal(imbinarize(img1), reconstructedFromSkeleton_8_img1)));

fprintf("Reconstruction of image 2 (4-connectivity) is the same as the original: %s\n", ...
    mat2str(isequal(imbinarize(img2), reconstructedFromSkeleton_4_img2)));

fprintf("Reconstruction of image 2 (8-connectivity) is the same as the original: %s\n", ...
    mat2str(isequal(imbinarize(img2), reconstructedFromSkeleton_8_img2)));





