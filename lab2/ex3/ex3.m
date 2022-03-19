clear all;
img = imread("../../images/horse.pgm");
figure(); imshow(img);

%% 3a - computing the 4-connectivity and 8-connectivity skeletons
%% and rendering the image based on the skeleton function defined
%% in the assignment body.
skeleton_4 = skeletonFunction(4, img);
figure(); imshow(skeleton_4);
unique_sets_4 = unique(skeleton_4);


skeleton_8 = skeletonFunction(8, img);
figure(); imshow(skeleton_8);
unique_sets_8 = unique(skeleton_8);





