function th = iterativeThreshold(imgIn, epsilon)
th = mean(imgIn, 'all'); % first meaningful t
while true 
    muF = mean(imgIn(imgIn >= th), 'all');
    muB = mean(imgIn(imgIn < th), 'all');
    thOld = th;
    th = (muF+muB)/2;
    if abs(th-thOld) < epsilon
        th = uint8(th);
        break;
    end
end
end



