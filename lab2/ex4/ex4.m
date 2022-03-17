clear all;

imgc = imread("images/colourflower.ppm");
imshow(imgc);

%[out, ~]  =quantization(3,1,imgc);

function [quantizedImage, means_matrix] = quantization(k, metric, imageIn)
        [H, W,~] = size(imageIn);
%         we initialize the means array with random uint8 gray scale values
        heights = randi([1 H], 1, k);
        widths = randi([1 W], 1, k);
  
        means = (imageIn(heights, widths,:));
   
        cluster_sizes = zeros(k,1);

        means_matrix = zeros(100, k, 3) ;
        
        for iteration = 1:100
        iteration
    %         for each iteration,    
    %         we create a clusters matrix and initialize all elements with
    %         zeros. Rows are the clusters and for each row, we have H * W
    %         columns (the maximum number of potential pixels a cluster can
    %         contain). It is not the most efficient, but still more efficient
    %         than direct indexing (imitating dynamic allocation)
            max_pixels_in_cluster = H * W;
            clusters = zeros(k, max_pixels_in_cluster, 3, 'uint8');
    
    
    %         we keep track of the current positions (for each row/cluster of
    %         the clusters matrix, we store the position where a newly-found
    %         element is inserted). It is initialized with ones, as the first
    %         index position in Matlab is 1
            current_positions = ones(1, k);
    
    %         we create a matrix the same size as the input image, where each
    %         pixel stores the cluster index
            label_matrix = zeros(H, W);

             if iteration ~= 1
                 means = means_matrix(iteration - 1, :, :);
             end

            for row = 1:H
                for column = 1:W
                    sum = 0;
                    for channel =1:3
                        sum =  sum + abs(double(means(:,:, channel)) - double(imageIn(row, column, channel)));
                     
                    end
                    size(sum)
                    [~, min_index] = min(sum);
                     
                    for cluster = 1:k
                        if min_index == cluster
                            clusters(min_index, current_positions(min_index),:) = imageIn(row, column,:);
                            current_positions(min_index) = current_positions(min_index) + 1;
                            label_matrix(row, column) = min_index;
                        end
                    end
                end
            end

            for cluster = 1:k
                nr_of_non_zero_elements = nnz(clusters(cluster,:));
                if nr_of_non_zero_elements ~= 0
                    for channel = 1:3
                    means(cluster, channel) =  sum(clusters(cluster,:,channel)) / nnz(clusters(cluster,:,channel));
                    end
        
                end
            end
           
            means_matrix(iteration, :, :) = means;
            
            if  iteration > 1 && all(abs(means_matrix(iteration,:) - means_matrix(iteration-1,:)) >= 1)   
                break;
            end
        end

        means = mean(means_matrix);
        
        for cluster = 1:k
            label_matrix(label_matrix == cluster) = means(cluster);
        end

       quantizedImage = uint8(label_matrix);
    end


