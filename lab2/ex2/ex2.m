clear all;
in =  imread("images/bacteria.pgm");
in = im2bw(in, 0.3);
n = 4;
se4 = strel("diamond", 1);
se8 = strel("square", 3);
out=in;

%% repeated dilation
for i=1:n
out= imdilate(out, se8);
end
%figure();imshow(out);

%% dilation with distance transform
out = dilationNfold(n, 8, in);
%figure();imshow(out);

out = in;
%% repeated erosion
for i=1:n
out= imerode(out, se8);
end
figure();imshow(out);

%% erosion with distance transform 
out = erosionNfold(n,8,in);
figure();imshow(out);
%%

