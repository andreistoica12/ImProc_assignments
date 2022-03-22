clear all;

%% original images
colourflower_rgb = imread("../../images/colourflower.ppm");
% figure(); imshow(colourflower_rgb);

peppers_rgb = imread("../../images/peppers.ppm");
% figure(); imshow(peppers_rgb);

poppies_rgb = imread("../../images/poppies.ppm");
% figure(); imshow(poppies_rgb);

roses_rgb = imread("../../images/roses.ppm");
% figure(); imshow(roses_rgb);

%% grey scale images
colourflower_gr = intensityFromRGB(colourflower_rgb);
% figure(); imshow(colourflower_gr);

peppers_gr = intensityFromRGB(peppers_rgb);
% figure(); imshow(peppers_gr);

poppies_gr = intensityFromRGB(poppies_rgb);
% figure(); imshow(poppies_gr);

roses_gr = intensityFromRGB(roses_rgb);
% figure(); imshow(roses_gr);

%% experiments from 4b, using the quantization function from lab 1
%% k = {1; 2; 4; 5; 6; 8; 10; 20; 30; 50; 100}
%% colourflower

[colourflower_k1, iter_col_k1] = quantization(colourflower_gr, 1);
figure(); imshow(colourflower_k1);
title("colourflower : k=1")

[colourflower_k2, iter_col_k2] = quantization(colourflower_gr, 2);
figure(); imshow(colourflower_k2);
title("colourflower : k=2")

[colourflower_k4, iter_col_k4] = quantization(colourflower_gr, 4);
figure(); imshow(colourflower_k4);
title("colourflower : k=4")

[colourflower_k5, iter_col_k5] = quantization(colourflower_gr, 5);
figure(); imshow(colourflower_k5);
title("colourflower : k=5")

[colourflower_k6, iter_col_k6] = quantization(colourflower_gr, 6);
figure(); imshow(colourflower_k6);
title("colourflower : k=6")

[colourflower_k8, iter_col_k8] = quantization(colourflower_gr, 8);
figure(); imshow(colourflower_k8);
title("colourflower : k=8")

[colourflower_k10, iter_col_k10] = quantization(colourflower_gr, 10);
figure(); imshow(colourflower_k10);
title("colourflower : k=10")

[colourflower_k20, iter_col_k20] = quantization(colourflower_gr, 20);
figure(); imshow(colourflower_k20);
title("colourflower : k=20")

[colourflower_k30, iter_col_k30] = quantization(colourflower_gr, 30);
figure(); imshow(colourflower_k30);
title("colourflower : k=30")

[colourflower_k50, iter_col_k50] = quantization(colourflower_gr, 50);
figure(); imshow(colourflower_k50);
title("colourflower : k=50")


%% k = 100
colourflower_k100 = quantization(colourflower_gr, 100);
figure(); imshow(colourflower_k100);
title("colourflower_gr : k=100")

%% peppers
[peppers_k1, iter_pep_k1] = quantization(peppers_gr, 1);
figure(); imshow(peppers_k1);
title("peppers : k=1")

[peppers_k2, iter_pep_k2] = quantization(peppers_gr, 2);
figure(); imshow(peppers_k2);
title("peppers : k=2")

[peppers_k4, iter_pep_k4] = quantization(peppers_gr, 4);
figure(); imshow(peppers_k4);
title("peppers : k=4")

[peppers_k5, iter_pep_k5] = quantization(peppers_gr, 5);
figure(); imshow(peppers_k5);
title("peppers : k=5")

[peppers_k6, iter_pep_k6] = quantization(peppers_gr, 6);
figure(); imshow(peppers_k6);
title("peppers : k=6")

[peppers_k8, iter_pep_k8] = quantization(peppers_gr, 8);
figure(); imshow(peppers_k8);
title("peppers : k=8")

[peppers_k10, iter_pep_k10] = quantization(peppers_gr, 10);
figure(); imshow(peppers_k10);
title("peppers : k=10")

[peppers_k20, iter_pep_k20] = quantization(peppers_gr, 20);
figure(); imshow(peppers_k20);
title("peppers : k=20")

[peppers_k30, iter_pep_k30] = quantization(peppers_gr, 30);
figure(); imshow(peppers_k30);
title("peppers : k=30")

[peppers_k50, iter_pep_k50] = quantization(peppers_gr, 50);
figure(); imshow(peppers_k50);
title("peppers : k=50")


%% poppies
[poppies_k1, iter_pop_k1] = quantization(poppies_gr, 1);
figure(); imshow(poppies_k1);
title("poppies : k=1")

[poppies_k2, iter_pop_k2] = quantization(poppies_gr, 2);
figure(); imshow(poppies_k2);
title("poppies : k=2")

[poppies_k4, iter_pop_k4] = quantization(poppies_gr, 4);
figure(); imshow(poppies_k4);
title("poppies : k=4")

[poppies_k5, iter_pop_k5] = quantization(poppies_gr, 5);
figure(); imshow(poppies_k5);
title("poppies : k=5")

[poppies_k6, iter_pop_k6] = quantization(poppies_gr, 6);
figure(); imshow(poppies_k6);
title("poppies : k=6")

[poppies_k8, iter_pop_k8] = quantization(poppies_gr, 8);
figure(); imshow(poppies_k8);
title("poppies : k=8")

[poppies_k10, iter_pop_k10] = quantization(poppies_gr, 10);
figure(); imshow(poppies_k10);
title("poppies : k=10")

[poppies_k20, iter_pop_k20] = quantization(poppies_gr, 20);
figure(); imshow(poppies_k20);
title("poppies : k=20")

[poppies_k30, iter_pop_k30] = quantization(poppies_gr, 30);
figure(); imshow(poppies_k30);
title("poppies : k=30")

[poppies_k50, iter_pop_k50] = quantization(poppies_gr, 50);
figure(); imshow(poppies_k50);
title("poppies : k=50")


%% roses
[roses_k1, iter_ros_k1] = quantization(roses_gr, 1);
figure(); imshow(roses_k1);
title("roses : k=1")

[roses_k2, iter_ros_k2] = quantization(roses_gr, 2);
figure(); imshow(roses_k2);
title("roses : k=2")

[roses_k4, iter_ros_k4] = quantization(roses_gr, 4);
figure(); imshow(roses_k4);
title("roses : k=4")

[roses_k5, iter_ros_k5] = quantization(roses_gr, 5);
figure(); imshow(roses_k5);
title("roses : k=5")

[roses_k6, iter_ros_k6] = quantization(roses_gr, 6);
figure(); imshow(roses_k6);
title("roses : k=6")

[roses_k8, iter_ros_k8] = quantization(roses_gr, 8);
figure(); imshow(roses_k8);
title("roses : k=8")

[roses_k10, iter_ros_k10] = quantization(roses_gr, 10);
figure(); imshow(roses_k10);
title("roses : k=10")

[roses_k20, iter_ros_k20] = quantization(roses_gr, 20);
figure(); imshow(roses_k20);
title("roses : k=20")

[roses_k30, iter_ros_k30] = quantization(roses_gr, 30);
figure(); imshow(roses_k30);
title("roses : k=30")

[roses_k50, iter_ros_k50] = quantization(roses_gr, 50);
figure(); imshow(roses_k50);
title("roses : k=50")