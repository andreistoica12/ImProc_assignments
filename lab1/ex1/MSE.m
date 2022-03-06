function mse = MSE(imageIn1,imageIn2)
    [H1, W1] = size(imageIn1);
    [H2, W2] = size(imageIn2);
    
%     we validate the size of the input images and we accept only images
%     with the same dimensions
    assert((H1 == H2) && (W1 == W2));

%     we need to work with matrices with element type double
    imageIn1_double = double(imageIn1);
    imageIn2_double = double(imageIn2);
    
    differences = imageIn1_double - imageIn2_double;
    squared_differences = differences .* differences;
    sum_of_squared_differences = sum(squared_differences, 'all');
    mse = sum_of_squared_differences / (H1 * W1);
end

