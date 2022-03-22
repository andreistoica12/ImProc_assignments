function imgOut = erosionNfold(n, connectivity, imgIn)
if connectivity == 4
 imgOut =  bwdist(~imgIn,'cityblock') > n;
else
 imgOut =  bwdist(~imgIn,'chessboard') > n; 
end
end
