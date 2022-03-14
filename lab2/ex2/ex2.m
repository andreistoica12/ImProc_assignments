clear all;
in =  imread("images/bacteria.pgm");
in = im2bw(in, 0.3);
figure();imshow(in);
n = 3;
se4 = strel("diamond", 1);
se8 = strel("square", 3);
out=in;

%% repeated dilation
for i=1:n
out= imdilate(in, se4);
end
%figure();imshow(out);

%% dilation with distance transform
out = dilationNfold(n, 4, in);
%figure();imshow(out);

%% repeated erosion
for i=1:n
out= imerode(in, se8);
end
figure();imshow(out);

%% erosion with distance transform 
out = erosionNfold(n,8,in);
figure();imshow(out);