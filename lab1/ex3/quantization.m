function [quantizedImage, means, clusters, current_positions, label_matrix] = quantization(imageIn, k)
%     we throw an error if the number of clusters is negative
    assert(k > 0);

%     as per the assignment, the output image will be the same as the input
%     image if the input image has fewer than k gray levels, so we first
%     compute the number of gray levels of the input image with the help of
%     the imhist() function. It returns two values, the pixel count and the
%     corresponding gray level (bin) in the image. Here, we input grayscale
%     images, to the second output value will be 256, regardless of the
%     image. Also, it is not used in our computations, so we we will not
%     store it.
    [pixelCounts,~] = imhist(imageIn);
%     we count how many gray level values are present in the image
    usedGrayLevels = nnz(pixelCounts);

    if usedGrayLevels < double(k)
        quantizedImage = imageIn;
    else
        [H, W] = size(imageIn);
%         we initialize the means array with random uint8 gray scale values
        means = uint8(randi([0, 255], 1, k));
        condition = length(means) ~= length(unique(means));
        while(condition)
            means = uint8(randi([0, 255], 1, k));
        end

%         NOT USED ANYMORE
% %         we initialize k empty cluster arrays. We will use direct indexing
% %         to add elements to the arrays dynamically.
% %         we dynamically create the k empty arrays. We need to be careful
% %         with the names, as they have to be different than other variables
% %         or functions.
%         for cluster = 1:k
%             eval(sprintf("cluster%d = []", cluster));
%         end
        
        
        for iteration = 1:5

    %         for each iteration,    
    %         we create a clusters matrix and initialize all elements with
    %         zeros. Rows are the clusters and for each row, we have H * W
    %         columns (the maximum number of potential pixels a cluster can
    %         contain). It is not the most efficient, but still more efficient
    %         than direct indexing (imitating dynamic allocation)
            max_pixels_in_cluster = H * W;
            clusters = zeros(k, max_pixels_in_cluster, 'uint8');
    
    
    %         we keep track of the current positions (for each row/cluster of
    %         the clusters matrix, we store the position where a newly-found
    %         element is inserted). It is initialized with ones, as the first
    %         index position in Matlab is 1
            current_positions = ones(1, k);
    
    %         we create a matrix the same size as the input image, where each
    %         pixel stores the cluster index
            label_matrix = zeros(H, W);

            for row = 1:H
                for column = 1:W
                    fprintf("Iteration %d,  pixel (%d, %d)\n", iteration, row, column);

                    [~, min_index] = min(abs(double(means) - double(imageIn(row, column))));
                    for cluster = 1:k
                        if min_index == cluster
                            clusters(min_index, current_positions(min_index)) = imageIn(row, column);
                            current_positions(min_index) = current_positions(min_index) + 1;
                            label_matrix(row, column) = min_index;
                        end
                    end
                end
            end

            for cluster = 1:k
                means(cluster) = sum(clusters(cluster,:)) / nnz(clusters(cluster,:));
            end                  
        end

        for cluster = 1:k
            label_matrix(label_matrix == cluster) = means(cluster);
        end

       quantizedImage = uint8(label_matrix);
    end
end

