clear all;
in =  imread("images/bacteria.pgm");
in = im2bw(in, 0.5);

n = 10;

%% repeated dilation
se4 = strel("diamond", 1);
se8 = strel("square", 3);
out=in;
for i=1:n
out= imdilate(in, se4);
end
figure();imshow(out);

%% dilation with distance transform
out = dilationNfold(n, 4, in);
figure();imshow(out);